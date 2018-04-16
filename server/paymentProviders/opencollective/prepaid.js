import Promise from 'bluebird';

import models from '../../models';
import { type as TransactionTypes } from '../../constants/transactions';
import roles from '../../constants/roles';
import * as paymentsLib from '../../lib/payments';

/** How much the platform charges per transaction: 5% */
export const PLATFORM_FEE = 0.05

export default {
  features: {
    recurring: false,
    waitToCharge: false
  },

  getBalance: (paymentMethod) => {
    return Promise.resolve({ amount: paymentMethod.monthlyLimitPerMember, currency: paymentMethod.currency});
  },

  processOrder: (order) => {
    /*
      - use gift card PaymentMethod (PM) to transfer money from gift card issuer to User
      - mark original gift card PM as "archivedAt" (it's used up)
      - create new PM type "opencollective" and attach to User (User now has credit in the system)
      - Use new PM to give money from User to Collective
    */

    const user = order.createdByUser;
    const originalPM = order.paymentMethod;

    let newPM, transactions;

    // Check that target Collective's Host is same as gift card issuer
    return order.collective.getHostCollective()
      .then(hostCollective => {
        if (hostCollective.id !== order.paymentMethod.CollectiveId) {
          console.log('Different host found');
          return Promise.resolve();
        } else {
          // transfer all money using gift card from Host to User
          const amounts = {
            // This is the amount in the host currency
            amount: order.paymentMethod.monthlyLimitPerMember, // treating this field as one-time limit
            currency: order.paymentMethod.currency,
            // This is the amount in the donor's currency
            fromAmount: order.totalAmount,
            fromCurrency: order.currency,
            fromCurrencyRate: 1, // assuming all USD transactions for now
          };
          const payload = {
            CreatedByUserId: user.id,
            FromCollectiveId: order.paymentMethod.CollectiveId,
            CollectiveId: user.CollectiveId,
            PaymentMethodId: order.PaymentMethodId,
            transaction: {
              ...amounts,
              type: TransactionTypes.CREDIT,
              OrderId: order.id,
              hostFeeInHostCurrency: 0,
              platformFeeInHostCurrency: 0, // we don't charge a fee until the money is used by User
              paymentProcessorFeeInHostCurrency: 0,
              description: order.paymentMethod.name,
              HostCollectiveId: order.paymentMethod.CollectiveId // hacky, HostCollectiveId doesn't quite make sense in this context but required by ledger. TODO: fix later.
            }
          };
          return models.Transaction.createFromPayload(payload)

          // mark gift card as used, so no one can use it again
          .then(() => order.paymentMethod.update({archivedAt: new Date()}))


          // create new payment method to allow User to use the money
          .then(() => models.PaymentMethod.create({
            name: originalPM.name,
            service: 'opencollective',
            type: 'collective', // changes to type collective
            confirmedAt: new Date(),
            CollectiveId: user.CollectiveId,
            CreatedByUserId: user.id,
            MonthlyLimitPerMember: originalPM.monthlyLimitPerMember,
            currency: originalPM.currency,
            token: null // we don't pass the gift card token on
          }))

          // Use the above payment method to donate to Collective
          .then(pm => newPM = pm)
          .then(() => {
            const hostFeeInHostCurrency = paymentsLib.calcFee(
              order.totalAmount,
              order.collective.hostFeePercent);
            const platformFeeInHostCurrency = paymentsLib.calcFee(
              order.totalAmount, PLATFORM_FEE);
            const amounts = {
              amount: order.totalAmount,
              currency: order.currency,
              fromAmount: order.totalAmount,
              fromCurrency: order.currency,
              fromCurrencyRate: 1,
            };
            const payload = {
              CreatedByUserId: user.id,
              FromCollectiveId: order.FromCollectiveId,
              CollectiveId: order.CollectiveId,
              PaymentMethodId: newPM.id,
              transaction: {
                ...amounts,
                type: TransactionTypes.CREDIT,
                OrderId: order.id,
                hostFeeInHostCurrency,
                platformFeeInHostCurrency,
                paymentProcessorFeeInHostCurrency: 0,
                description: order.description
              }
            }

            return models.Transaction.createFromPayload(payload)
              .then(t => transactions = t)

              // add roles
              .then(() => order.collective.findOrAddUserWithRole({ id: user.id, CollectiveId: order.fromCollective.id}, roles.BACKER, {
                CreatedByUserId: user.id, TierId: order.TierId }))

              // Mark order row as processed
              .then(() => order.update({ processedAt: new Date() }))

              // Mark paymentMethod as confirmed
              .then(() => newPM.update({ confirmedAt: new Date() }))

              .then(() => transactions); // make sure we return the transactions created
          })
        }
      });
  }
}
