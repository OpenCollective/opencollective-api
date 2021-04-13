import { v4 as uuid } from 'uuid';

import { maxInteger } from '../../constants/math';
import { FEES_ON_TOP_TRANSACTION_PROPERTIES, TransactionTypes } from '../../constants/transactions';
import { getFxRate } from '../../lib/currency';
import { calcFee, getHostFeePercent, getPlatformFeePercent } from '../../lib/payments';
import models from '../../models';

const paymentMethodProvider = {};

paymentMethodProvider.features = {
  recurring: false,
  waitToCharge: false,
};

// We don't check balance for "Added Funds"
paymentMethodProvider.getBalance = () => {
  return Promise.resolve(maxInteger);
};

paymentMethodProvider.createPlatformTipTransaction = async transaction => {
  const TransactionGroup = transaction.TransactionGroup || uuid();
  const donationTransaction = {
    ...transaction,
    amount: transaction.data.platformTipInHostCurrency,
    description: 'Financial contribution (Platform Tip) to Open Collective',
    netAmountInCollectiveCurrency: transaction.data.platformTipInHostCurrency,
    FromCollectiveId: transaction.HostCollectiveId,
    hostCurrencyFxRate: 1,
    TransactionGroup,
    PlatformTipForTransactionGroup: TransactionGroup,
    ...FEES_ON_TOP_TRANSACTION_PROPERTIES,
  };

  return models.Transaction.createDoubleEntry(donationTransaction);
};

paymentMethodProvider.processOrder = async order => {
  const collectiveHost = await order.collective.getHostCollective();

  if (order.paymentMethod.CollectiveId !== order.collective.HostCollectiveId) {
    throw new Error('Can only use the Host payment method to Add Funds to an hosted Collective.');
  }

  const hostFeePercent = await getHostFeePercent(order);

  const platformFeePercent = await getPlatformFeePercent(order);

  const payload = {
    CreatedByUserId: order.CreatedByUserId,
    FromCollectiveId: order.FromCollectiveId,
    CollectiveId: order.CollectiveId,
    PaymentMethodId: order.PaymentMethodId,
  };

  // Different collectives on the same host may have different currencies
  // That's bad design. We should always keep the same host currency everywhere and only use the currency
  // of the collective for display purposes (using the fxrate at the time of display)
  // Anyway, until we change that, when we give money to a collective that has a different currency
  // we need to compute the equivalent using the fxrate of the day
  const fxrate = await getFxRate(order.currency, collectiveHost.currency);
  const totalAmountInPaymentMethodCurrency = order.totalAmount * fxrate;

  const hostFeeInHostCurrency = calcFee(order.totalAmount * fxrate, hostFeePercent);
  const platformFeeInHostCurrency = calcFee(order.totalAmount * fxrate, platformFeePercent);
  let platformTipInHostCurrency;
  if (order.data?.platformTip) {
    platformTipInHostCurrency = order.data?.platformTip * fxrate;
  }

  payload.transaction = {
    type: TransactionTypes.CREDIT,
    OrderId: order.id,
    amount: order.totalAmount,
    currency: order.currency,
    hostCurrency: collectiveHost.currency,
    hostCurrencyFxRate: fxrate,
    netAmountInCollectiveCurrency: order.totalAmount * (1 - hostFeePercent / 100),
    amountInHostCurrency: totalAmountInPaymentMethodCurrency,
    hostFeeInHostCurrency,
    platformFeeInHostCurrency,
    paymentProcessorFeeInHostCurrency: 0,
    description: order.description,
    data: { platformTipInHostCurrency },
  };

  if (platformTipInHostCurrency) {
    return await paymentMethodProvider.createPlatformTipTransaction(payload.transaction);
  }

  if (payload.transaction.amount > 0) {
    return await models.Transaction.createFromPayload(payload);
  }
};

export default paymentMethodProvider;
