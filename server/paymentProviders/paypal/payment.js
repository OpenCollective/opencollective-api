import { get, isNumber } from 'lodash';

import * as constants from '../../constants/transactions';
import { getFxRate } from '../../lib/currency';
import logger from '../../lib/logger';
import { floatAmountToCents } from '../../lib/math';
import { getHostFee, getPlatformFee } from '../../lib/payments';
import { paypalAmountToCents } from '../../lib/paypal';
import models from '../../models';

import { paypalRequest, paypalRequestV2 } from './api';

/** Create a new payment object in the PayPal API
 *
 * It's just a wrapper to the PayPal API method `create-payment':
 * https://developer.paypal.com/docs/integration/direct/express-checkout/integration-jsv4/advanced-payments-api/create-express-checkout-payments/
 */
export async function createPayment(req, res) {
  const { amount, currency, hostId } = req.body;
  if (!amount || !currency) {
    throw new Error('Amount & Currency are required');
  }
  const hostCollective = await models.Collective.findByPk(hostId);
  if (!hostCollective) {
    throw new Error("Couldn't find host collective");
  }
  /* eslint-disable camelcase */
  const paymentParams = {
    intent: 'sale',
    payer: { payment_method: 'paypal' },
    transactions: [{ amount: { total: amount, currency } }],
    /* The values bellow are required by the PayPal API but they're
       not really used so they were just filled in with something
       reasonable. */
    redirect_urls: {
      return_url: 'https://opencollective.com',
      cancel_url: 'https://opencollective.com',
    },
  };
  /* eslint-enable camelcase */
  const payment = await paypalRequest('payments/payment', paymentParams, hostCollective);
  return res.json({ id: payment.id });
}

/** Execute an already created payment
 *
 * It's just a wrapper to the PayPal API method `execute-payment':
 * https://developer.paypal.com/docs/integration/direct/express-checkout/execute-payments/
 */
export async function executePayment(order) {
  const hostCollective = await order.collective.getHostCollective();
  const { paymentID, payerID } = order.paymentMethod.data;
  return paypalRequest(
    `payments/payment/${paymentID}/execute`,
    {
      payer_id: payerID, // eslint-disable-line camelcase
    },
    hostCollective,
  );
}

/** Create transaction in our database to reflect a PayPal charge */
const recordTransaction = async (order, amount, currency, paypalFee, payload) => {
  const host = await order.collective.getHostCollective();
  if (!host) {
    throw new Error(`Cannot create transaction: collective id ${order.collective.id} doesn't have a host`);
  }
  const hostCurrency = host.currency;
  const hostPlan = await host.getPlan();
  const hostFeeSharePercent = isNumber(hostPlan?.paypalHostFeeSharePercent)
    ? hostPlan?.paypalHostFeeSharePercent
    : hostPlan?.hostFeeSharePercent;
  const isSharedRevenue = !!hostFeeSharePercent;
  const platformTip = order.data?.platformFee;

  const hostCurrencyFxRate = await getFxRate(currency, hostCurrency);
  const amountInHostCurrency = Math.round(hostCurrencyFxRate * amount);
  const paymentProcessorFeeInHostCurrency = Math.round(hostCurrencyFxRate * paypalFee);
  const hostFeeInHostCurrency = await getHostFee(amountInHostCurrency, order);
  const platformFeeInHostCurrency = isSharedRevenue
    ? platformTip || 0
    : await getPlatformFee(amountInHostCurrency, order, host, { hostFeeSharePercent });

  return models.Transaction.createFromPayload({
    CreatedByUserId: order.CreatedByUserId,
    FromCollectiveId: order.FromCollectiveId,
    CollectiveId: order.CollectiveId,
    PaymentMethodId: order.PaymentMethodId,
    transaction: {
      type: constants.TransactionTypes.CREDIT,
      OrderId: order.id,
      amount,
      currency,
      amountInHostCurrency,
      hostCurrency,
      hostCurrencyFxRate,
      hostFeeInHostCurrency,
      platformFeeInHostCurrency,
      paymentProcessorFeeInHostCurrency,
      taxAmount: order.taxAmount,
      description: order.description,
      data: {
        ...payload,
        isFeesOnTop: order.data?.isFeesOnTop,
        platformTip: order.data?.platformFee,
        isSharedRevenue,
        hostFeeSharePercent,
      },
    },
  });
};

export async function createTransaction(order, paymentInfo) {
  const transaction = paymentInfo.transactions[0];
  const currency = transaction.amount.currency;
  const amount = paypalAmountToCents(transaction.amount.total);
  const paypalTransactionFee = parseFloat(get(transaction, 'related_resources.0.sale.transaction_fee.value', '0.0'));
  const paymentProcessorFee = floatAmountToCents(paypalTransactionFee);
  return recordTransaction(order, amount, currency, paymentProcessorFee, paymentInfo);
}

export function recordPaypalSale(order, paypalSale) {
  const currency = paypalSale.amount.currency;
  const amount = paypalAmountToCents(paypalSale.amount.total);
  const fee = paypalAmountToCents(get(paypalSale, 'transaction_fee.value', '0.0'));
  return recordTransaction(order, amount, currency, fee, { paypalSale });
}

export function recordPaypalTransaction(order, paypalTransaction) {
  const currency = paypalTransaction.amount_with_breakdown.gross_amount.currency_code;
  const amount = floatAmountToCents(parseFloat(paypalTransaction.amount_with_breakdown.gross_amount.value));
  const fee = parseFloat(get(paypalTransaction.amount_with_breakdown, 'fee_amount.value', '0.0'));
  return recordTransaction(order, amount, currency, fee, { paypalTransaction });
}

const recordPaypalCapture = async (order, capture) => {
  const currency = capture.amount.currency;
  const amount = paypalAmountToCents(capture.amount.value);
  const fee = paypalAmountToCents(get(capture, 'seller_receivable_breakdown.paypal_fee.value', '0.0'));
  return recordTransaction(order, amount, currency, fee, { capture });
};

/** Process order in paypal and create transactions in our db */
export async function processOrder(order) {
  if (order.paymentMethod.data.isNewApi) {
    if (order.paymentMethod.data.orderId) {
      const hostCollective = await order.collective.getHostCollective();
      const orderId = order.paymentMethod.data.orderId;
      const capture = await paypalRequestV2(`checkout/orders/${orderId}/capture`, hostCollective, 'POST');
      const captureId = capture.purchase_units[0].payments.captures[0].id;
      const captureDetails = await paypalRequestV2(`payments/captures/${captureId}`, hostCollective, 'GET');
      return recordPaypalCapture(order, captureDetails);
    } else {
      throw new Error('Must provide an orderId');
    }
  } else {
    const paymentInfo = await executePayment(order);
    logger.info('PayPal Payment');
    logger.info(paymentInfo);
    const transaction = await createTransaction(order, paymentInfo);
    await order.update({ processedAt: new Date() });
    await order.paymentMethod.update({ confirmedAt: new Date() });
    return transaction;
  }
}

/* Interface expected for a payment method */
export default {
  features: { recurring: false },
  processOrder,
};
