
import async from 'async';
import _ from 'lodash';
import activities from '../constants/activities';
import {planId} from '../lib/utils';
import {appStripe, extractFees} from '../gateways/stripe';
import models, {sequelize} from '../models';
import errors from '../lib/errors';
import {type} from '../constants/transactions';
import emailLib from '../lib/email';
import currencies from '../constants/currencies';

const {
  Activity,
  Donation,
  Group,
  Subscription,
  Transaction,
  User,
  PaymentMethod
} = models;

export default function stripeWebhook(req, res, next) {
  const { body } = req;
  const isProduction = process.env.NODE_ENV === 'production';

  // Stripe send test events to production as well
  // don't do anything if the event is not livemode
  if (isProduction && !body.livemode) {
    return res.sendStatus(200);
  }

  async.auto({
    fetchEvent: (cb) => {

      /**
       * We check the event on stripe to be sure we don't get a fake event from
       * someone else
       */
      appStripe.events.retrieve(body.id, {
        stripe_account: body.user_id
      })
      .then(event => {
        if (event.type !== 'invoice.payment_succeeded') {
          return cb(new errors.BadRequest('Wrong event type received'));
        }

        const invoice = event.data.object;
        const invoiceLineItems = invoice.lines.data;
        const stripeSubscription = _.find(invoiceLineItems, { type: 'subscription' });

        /**
         * With connected accounts we get all the events of the account
         * We will return a 200 if the plan is not in our format (not generated by us)
         * Example: Ruby together has a subscription model outside of us.
         * https://dashboard.stripe.com/acct_15avvkAcWgwn5pBt/events/evt_17oYejAcWgwn5pBtRo5gRiyY
         */
        if (planId(stripeSubscription.plan) !== stripeSubscription.plan.id) {
          return res.sendStatus(200);
        }

        /*
         * In case we get $0 donation, return 200. Otherwise, Stripe will keep pinging us.
         */
        if (event.data.object.amount_due === 0) {
          return res.sendStatus(200);
        }

        cb(null, {
          event,
          stripeSubscription
        });
      })
      .catch(cb);
    },

    createActivity: ['fetchEvent', (cb, results) => {
      // Only save activity when the event is valid
      Activity.create({
        type: activities.WEBHOOK_STRIPE_RECEIVED,
        data: {
          event: results.fetchEvent.event,
          stripeAccount: body.user_id,
          eventId: body.id,
          dashboardUrl: `https://dashboard.stripe.com/${body.user_id}/events/${body.id}`
        }
      })
      .then(activity => cb(null, activity))
      .catch(cb);
    }],

    fetchDonation: ['createActivity', (cb, results) => {
      const stripeSubscriptionId = results.fetchEvent.stripeSubscription.id;

      Donation.findOne({
        include: [
          { model: Group },
          { model: User },
          { model: Subscription, where: { stripeSubscriptionId } }
        ]
      })
      .then((donation) => {
        /**
         * Stripe doesn't make a difference between development, test, staging
         * environments. If we get a webhook from another env,
         * `transaction.Subscription.stripeSubscriptionId`
         * will not be found and throw an error. Stripe will retry to send the webhook
         * if it doesn't get a 2XX status code.
         * For non-production environments, we will simply return 200 to avoid
         * the retry on Stripe side (and the email from Stripe support).
         */
        if (!donation && !isProduction) {
          return res.sendStatus(200);
        }

        if (!donation) {
          return cb(new errors.BadRequest('Donation not found: unknown subscription id'));
        }
        return cb(null, donation);
      })
      .catch(cb)
    }],

    confirmUniqueChargeId: ['fetchDonation', (cb, results) => {
      const chargeId = results.fetchEvent.event.data.object.charge;
      const donationId = results.fetchDonation.id;
      sequelize.query(`
        SELECT * FROM "Transactions"
        WHERE 
          "DonationId" = ${donationId} AND
          CAST(data->'charge'->'id' AS TEXT) like '%${chargeId}%' AND
          "deletedAt" IS NULL
        `.replace(/\s\s+/g, ' '),
        {
          model: Transaction
        })
      .then(t => {
        if (t.length > 0) {
          cb(new errors.BadRequest(`This chargeId: ${chargeId} already exists.`))
        } else {
          cb(null, true);
        }
      })
    }],

    fetchPaymentMethod: ['confirmUniqueChargeId', (cb, results) => {
      const userId = results.fetchDonation.UserId;
      const { customer } = results.fetchEvent.event.data.object;


      if (!customer) {
        return cb(new errors.BadRequest(`Customer Id not found. Event id: ${results.fetchEvent.event.id}`));
      }

      PaymentMethod.findOne({
        where: {
          customerId: customer,
          UserId: userId
        }
      })
      .then((paymentMethod) => {
        if (!paymentMethod) {
          return cb(new errors.BadRequest('PaymentMethod not found: unknown customer'));
        }
        return cb(null, paymentMethod);
      })
      .catch(cb)
    }],

    retrieveCharge: ['fetchPaymentMethod', (cb, results) => {
      const chargeId = results.fetchEvent.event.data.object.charge;
      appStripe.charges.retrieve(chargeId, {
        stripe_account: body.user_id
      })
      .then(charge => {
        if (!charge) {
          return cb(new errors.BadRequest(`ChargeId not found: ${chargeId}`));
        }
        return cb(null, charge);
      })
      .catch(cb);
    }],

    retrieveBalance: ['retrieveCharge', (cb, results) => {
      const charge = results.retrieveCharge;
      appStripe.balance.retrieveTransaction(charge.balance_transaction, {
        stripe_account: body.user_id
      })
      .then(balanceTransaction => {
        if (!balanceTransaction) {
          return cb(new errors.BadRequest(`Balance transaction not found for chargeId: ${charge.id}`));
        }
        return cb(null, balanceTransaction);
      })
      .catch(cb);
    }],

    createTransaction: ['retrieveBalance', (cb, results) => {
      const donation = results.fetchDonation;
      const { stripeSubscription } = results.fetchEvent;
      const user = donation.User || {};
      const group = donation.Group || {};
      const paymentMethod = results.fetchPaymentMethod;
      const charge = results.retrieveCharge;
      const balanceTransaction = results.retrieveBalance;
      const fees = extractFees(balanceTransaction);
      const { hostFeePercent } = group;

      // Now we record a new transaction
      const newTransaction = {
        type: type.DONATION,
        DonationId: donation.id,
        amount: stripeSubscription.amount,
        currency: stripeSubscription.currency,
        txnCurrency: balanceTransaction.currency,
        amountInTxnCurrency: balanceTransaction.amount,
        txnCurrencyFxRate: donation.amount/balanceTransaction.amount,
        hostFeeInTxnCurrency: parseInt(balanceTransaction.amount*hostFeePercent/100, 10),
        platformFeeInTxnCurrency: fees.applicationFee,
        paymentProcessorFeeInTxnCurrency: fees.stripeFee,
        data: {charge, balanceTransaction},
        description: `${donation.Subscription.interval}ly recurring subscription`,
      };

      models.Transaction.createFromPayload({
        transaction: newTransaction,
        user,
        group,
        paymentMethod
      })
      .then(t => cb(null, t))
      .catch(cb);
    }],

    sendInvoice: ['createTransaction', (cb, results) => {
      const donation = results.fetchDonation;
      const transaction = results.createTransaction;
      // We only send an invoice for donations > $10 equivalent
      if (donation.amount < 10 * currencies[donation.currency].fxrate * 100) return cb(null);
      const user = donation.User || {};
      const group = donation.Group || {};
      const subscription = donation.Subscription;
      group.getRelatedGroups(2, 0)
      .then((relatedGroups) => emailLib.send(
        'thankyou',
        user.email,
        { donation: donation.info,
          transaction: transaction.info,
          user: user.info,
          firstPayment: false,
          group: group.info,
          relatedGroups,
          interval: subscription && subscription.interval,
          subscriptionsLink: user.generateLoginLink('/subscriptions')
        }, {
          from: `${group.name} <organizers@${group.slug}.opencollective.com>`
        }))
      .then(() => cb())
      .catch(cb);
    }]

  }, (err) => {
    if (err) return next(err);

    /**
     * We need to return a 200 to tell stripe to not retry the webhook.
     */
    res.sendStatus(200);
  });

}
