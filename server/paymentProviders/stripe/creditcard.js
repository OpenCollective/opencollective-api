import _ from 'lodash';
import config from 'config';
import Stripe from 'stripe';

import models from '../../models';
import * as constants from '../../constants/transactions';
import * as stripeGateway from './gateway';
import * as paymentsLib from '../../lib/payments';

const stripe = Stripe(config.stripe.secret);

/**
 * Get or create a customer under the platform stripe account
 */
const getOrCreateCustomerOnPlatformAccount = async ({ paymentMethod, user }) => {
  if (paymentMethod.customerId) {
    return stripe.customers.retrieve(paymentMethod.customerId);
  }

  const customer = await stripe.customers.create({ source: paymentMethod.token, email: user.email });

  paymentMethod.customerId = customer.id;
  await paymentMethod.update({ customerId: customer.id });

  return customer;
};

/**
 * Get the customerId for the Stripe Account of the Host
 * Or create one using the Stripe token associated with the platform (paymentMethod.token)
 * and saves it under PaymentMethod.data[hostStripeAccount.username]
 * @param {*} hostStripeAccount
 */
const getOrCreateCustomerOnHostAccount = async (hostStripeAccount, { paymentMethod, user }) => {
  // Customers pre-migration will have their stripe user connected
  // to the platform stripe account, not to the host's stripe
  // account. Since payment methods had no name before that
  // migration, we're using it to test for pre-migration users;
  if (!paymentMethod.name) return paymentMethod.customerId;

  const data = paymentMethod.data || {};
  data.customerIdForHost = data.customerIdForHost || {};
  if (data.customerIdForHost[hostStripeAccount.username]) {
    return stripe.customers.retrieve(data.customerIdForHost[hostStripeAccount.username], {
      stripe_account: hostStripeAccount.username,
    });
  } else {
    // More info about that
    // - Documentation: https://stripe.com/docs/connect/shared-customers
    // - API: https://stripe.com/docs/api/tokens/create_card
    const token = await stripe.tokens.create(
      { customer: paymentMethod.customerId },
      { stripe_account: hostStripeAccount.username },
    );

    const customer = await stripe.customers.create(
      { source: token.id, email: user.email },
      { stripe_account: hostStripeAccount.username },
    );

    data.customerIdForHost[hostStripeAccount.username] = customer.id;
    paymentMethod.data = data;
    await paymentMethod.update({ data });

    return customer;
  }
};

/**
 * Returns a Promise with the transaction created
 * Note: we need to create a token for hostStripeAccount because paymentMethod.customerId is a customer of the platform
 * See: Shared Customers: https://stripe.com/docs/connect/shared-customers
 */
const createChargeAndTransactions = async (
  hostStripeAccount,
  { order, platformStripeCustomer, hostStripeCustomer },
) => {
  const { collective, createdByUser: user, paymentMethod } = order;

  const platformFee = isNaN(order.platformFee)
    ? parseInt((order.totalAmount * constants.OC_FEE_PERCENT) / 100, 10)
    : order.platformFee;

  // TODO: double check if we really want Setup Intents supported here
  let setupIntent;
  if (!paymentMethod.data.setupIntent) {
    setupIntent = await stripe.setupIntents.create({
      customer: platformStripeCustomer.id,
      payment_method: platformStripeCustomer.sources.data[0].id,
      confirm: true,
    });
  } else {
    setupIntent = await stripe.setupIntents.retrieve(paymentMethod.data.setupIntent.id);
  }

  if (!paymentMethod.data.setupIntent || paymentMethod.data.setupIntent.status !== setupIntent.status) {
    paymentMethod.data.setupIntent = { id: setupIntent.id, status: setupIntent.status };
    await paymentMethod.update({ data: paymentMethod.data });
  }

  if (setupIntent.next_action) {
    const setupIntentError = new Error('Setup Intent require action');
    setupIntentError.stripeResponse = { setupIntent };
    throw setupIntentError;
  }

  let paymentIntent;
  if (!order.data.paymentIntent) {
    paymentIntent = await stripe.paymentIntents.create(
      {
        amount: order.totalAmount,
        currency: order.currency,
        customer: hostStripeCustomer.id,
        description: order.description,
        application_fee_amount: platformFee,
        confirm: true,
        confirmation_method: 'manual',
        // TODO: implement return_url (could not find any way to test that)
        // TODO: this should be only set when user save the credit card or subscription
        setup_future_usage: 'off_session',
        metadata: {
          from: `${config.host.website}/${order.fromCollective.slug}`,
          to: `${config.host.website}/${order.collective.slug}`,
          customerEmail: user.email,
        },
      },
      {
        stripe_account: hostStripeAccount.username,
      },
    );
  } else {
    paymentIntent = await stripe.paymentIntents.confirm(order.data.paymentIntent.id, {
      stripe_account: hostStripeAccount.username,
    });
  }

  if (!order.data.paymentIntent || order.data.paymentIntent.status !== paymentIntent.status) {
    order.data.paymentIntent = { id: paymentIntent.id, status: paymentIntent.status };
    await order.update({ data: order.data });
  }

  if (paymentIntent.next_action) {
    const paymentIntentError = new Error('Payment Intent require action');
    paymentIntentError.stripeAccount = hostStripeAccount.username;
    paymentIntentError.stripeResponse = { paymentIntent };
    throw paymentIntentError;
  }

  const charge = paymentIntent.charges.data[0];

  const balanceTransaction = await stripe.balanceTransactions.retrieve(charge.balance_transaction, {
    stripe_account: hostStripeAccount.username,
  });

  // Create a Transaction
  const fees = stripeGateway.extractFees(balanceTransaction);
  const hostFeeInHostCurrency = paymentsLib.calcFee(balanceTransaction.amount, collective.hostFeePercent);
  const payload = {
    CreatedByUserId: user.id,
    FromCollectiveId: order.FromCollectiveId,
    CollectiveId: collective.id,
    PaymentMethodId: paymentMethod.id,
    transaction: {
      type: constants.TransactionTypes.CREDIT,
      OrderId: order.id,
      amount: order.totalAmount,
      currency: order.currency,
      hostCurrency: balanceTransaction.currency,
      amountInHostCurrency: balanceTransaction.amount,
      hostCurrencyFxRate: balanceTransaction.amount / order.totalAmount,
      hostFeeInHostCurrency,
      platformFeeInHostCurrency: fees.applicationFee,
      paymentProcessorFeeInHostCurrency: fees.stripeFee,
      taxAmount: order.taxAmount,
      description: order.description,
      data: { charge, balanceTransaction },
    },
  };

  return models.Transaction.createFromPayload(payload);
};

export default {
  features: {
    recurring: true,
    waitToCharge: false,
  },

  processOrder: async order => {
    const hostStripeAccount = await order.collective.getHostStripeAccount();

    const platformStripeCustomer = await getOrCreateCustomerOnPlatformAccount({
      paymentMethod: order.paymentMethod,
      user: order.createdByUser,
    });

    const hostStripeCustomer = await getOrCreateCustomerOnHostAccount(hostStripeAccount, {
      paymentMethod: order.paymentMethod,
      user: order.createdByUser,
    });

    const transactions = await createChargeAndTransactions(hostStripeAccount, {
      order,
      platformStripeCustomer,
      hostStripeCustomer,
    });

    // Mark paymentMethod as confirmed
    await order.paymentMethod.update({ confirmedAt: new Date() });

    return transactions;
  },

  /** Refund a given transaction */
  refundTransaction: async (transaction, user) => {
    /* What's going to be refunded */
    const chargeId = _.result(transaction.data, 'charge.id');

    /* From which stripe account it's going to be refunded */
    const collective = await models.Collective.findByPk(
      transaction.type === 'CREDIT' ? transaction.CollectiveId : transaction.FromCollectiveId,
    );
    const hostStripeAccount = await collective.getHostStripeAccount();

    /* Refund both charge & application fee */
    const refund = await stripeGateway.refundCharge(hostStripeAccount, chargeId);
    const charge = await stripeGateway.retrieveCharge(hostStripeAccount, chargeId);
    const refundBalance = await stripeGateway.retrieveBalanceTransaction(hostStripeAccount, refund.balance_transaction);
    const fees = stripeGateway.extractFees(refundBalance);

    /* Create negative transactions for the received transaction */
    const refundTransaction = await paymentsLib.createRefundTransaction(
      transaction,
      fees.stripeFee,
      {
        refund,
        balanceTransaction: refundBalance,
      },
      user,
    );

    /* Associate RefundTransactionId to all the transactions created */
    return paymentsLib.associateTransactionRefundId(transaction, refundTransaction, {
      ...transaction.data,
      charge,
    });
  },

  /** Refund a given transaction that was already refunded
   * in stripe but not in our database
   */
  refundTransactionOnlyInDatabase: async (transaction, user) => {
    /* What's going to be refunded */
    const chargeId = _.result(transaction.data, 'charge.id');

    /* From which stripe account it's going to be refunded */
    const collective = await models.Collective.findByPk(
      transaction.type === 'CREDIT' ? transaction.CollectiveId : transaction.FromCollectiveId,
    );
    const hostStripeAccount = await collective.getHostStripeAccount();

    /* Refund both charge & application fee */
    const { charge, refund } = await stripeGateway.retrieveChargeWithRefund(hostStripeAccount, chargeId);
    if (!refund) {
      throw new Error('No refunds found in stripe.');
    }
    const refundBalance = await stripeGateway.retrieveBalanceTransaction(hostStripeAccount, refund.balance_transaction);
    const fees = stripeGateway.extractFees(refundBalance);

    /* Create negative transactions for the received transaction */
    const refundTransaction = await paymentsLib.createRefundTransaction(
      transaction,
      fees.stripeFee,
      {
        refund,
        balanceTransaction: refundBalance,
      },
      user,
    );

    /* Associate RefundTransactionId to all the transactions created */
    return paymentsLib.associateTransactionRefundId(transaction, refundTransaction, {
      ...transaction.data,
      charge,
    });
  },

  webhook: (/* requestBody, event */) => {
    // We don't do anything at the moment
    return Promise.resolve();
  },
};
