/* eslint-disable camelcase */
import crypto from 'crypto';

import { expect } from 'chai';
import sinon from 'sinon';

import status from '../../../../server/constants/expense_status';
import * as paypalLib from '../../../../server/lib/paypal';
import { PayoutMethodTypes } from '../../../../server/models/PayoutMethod';
import * as paypalPayouts from '../../../../server/paymentProviders/paypal/payouts';
import { fakeCollective, fakeConnectedAccount, fakeExpense, fakePayoutMethod } from '../../../test-helpers/fake-data';
import * as utils from '../../../utils';

describe('paymentMethods/paypal/payouts.js', () => {
  const sandbox = sinon.createSandbox();
  let expense, host, collective, payoutMethod;

  afterEach(sandbox.restore);
  beforeEach(utils.resetTestDB);

  describe('payExpensesBatch', () => {
    let expense, host, collective, payoutMethod;
    beforeEach(async () => {
      host = await fakeCollective({ isHostAccount: true });
      await fakeConnectedAccount({
        CollectiveId: host.id,
        service: 'paypal',
        clientId: 'fake',
        token: 'fake',
      });
      collective = await fakeCollective({ HostCollectiveId: host.id });
      payoutMethod = await fakePayoutMethod({
        type: PayoutMethodTypes.PAYPAL,
        data: {
          email: 'nicolas@cage.com',
        },
      });
      expense = await fakeExpense({
        status: status.SCHEDULED_FOR_PAYMENT,
        amount: 10000,
        CollectiveId: collective.id,
        currency: 'USD',
        PayoutMethodId: payoutMethod.id,
        category: 'Engineering',
        type: 'INVOICE',
        description: 'May Invoice',
      });
      await fakeExpense({
        status: status.PAID,
        amount: 10000,
        CollectiveId: collective.id,
        currency: 'USD',
        PayoutMethodId: payoutMethod.id,
        category: 'Engineering',
        type: 'INVOICE',
        description: 'January Invoice',
      });
      expense.collective = collective;
      expense.PayoutMethod = payoutMethod;
      sandbox.stub(paypalLib, 'executePayouts').resolves({ batch_header: { payout_batch_id: 'fake' } });
    });

    it('should pay all expenses scheduled for payment', async () => {
      await paypalPayouts.payExpensesBatch([expense]);
      await expense.reload();

      sinon.assert.calledOnce(paypalLib.executePayouts);
      expect(expense.data).to.deep.equals({ payout_batch_id: 'fake' });
    });

    it('should generate unique sender_batch_id', async () => {
      await paypalPayouts.payExpensesBatch([expense]);
      const expectedHash = crypto.createHash('SHA1').update(expense.id.toString()).digest('hex');

      expect(paypalLib.executePayouts.firstCall.lastArg)
        .to.have.nested.property('sender_batch_header.sender_batch_id')
        .equals(expectedHash);
    });
  });

  describe('checkBatchStatus', () => {
    beforeEach(async () => {
      host = await fakeCollective({ isHostAccount: true });
      await fakeConnectedAccount({
        CollectiveId: host.id,
        service: 'paypal',
        clientId: 'fake',
        token: 'fake',
      });
      collective = await fakeCollective({ HostCollectiveId: host.id });
      payoutMethod = await fakePayoutMethod({
        type: PayoutMethodTypes.PAYPAL,
        data: {
          email: 'nicolas@cage.com',
        },
      });
      expense = await fakeExpense({
        status: status.PROCESSING,
        amount: 10000,
        CollectiveId: collective.id,
        currency: 'USD',
        PayoutMethodId: payoutMethod.id,
        category: 'Engineering',
        type: 'INVOICE',
        description: 'May Invoice',
        data: { payout_batch_id: 'fake-batch-id' },
      });
      await fakeExpense({
        status: status.PAID,
        amount: 10000,
        CollectiveId: collective.id,
        currency: 'USD',
        PayoutMethodId: payoutMethod.id,
        category: 'Engineering',
        type: 'INVOICE',
        description: 'January Invoice',
      });
      expense.collective = collective;
      sandbox.stub(paypalLib, 'getBatchInfo');
    });

    it('should create a transaction and mark expense as paid if transaction status is SUCCESS', async () => {
      paypalLib.getBatchInfo.resolves({
        items: [
          {
            transaction_status: 'SUCCESS',
            payout_item: { sender_item_id: expense.id.toString() },
            payout_batch_id: 'fake-batch-id',
            payout_item_fee: {
              currency: 'USD',
              value: '1.23',
            },
          },
        ],
      });

      await paypalPayouts.checkBatchStatus([expense]);
      const [transaction] = await expense.getTransactions({ where: { type: 'DEBIT' } });

      expect(paypalLib.getBatchInfo.getCall(0)).to.have.property('lastArg', 'fake-batch-id');
      expect(expense).to.have.property('status', 'PAID');
      expect(transaction).to.have.property('paymentProcessorFeeInHostCurrency', -123);
      expect(transaction).to.have.property('netAmountInCollectiveCurrency', -10123);
    });

    it('work with cross-currency collectives', async () => {
      const expense = await fakeExpense({
        status: status.PROCESSING,
        amount: 10000,
        CollectiveId: collective.id,
        currency: 'EUR',
        PayoutMethodId: payoutMethod.id,
        category: 'Engineering',
        type: 'INVOICE',
        description: 'May Invoice',
        data: { payout_batch_id: 'fake-batch-id-eur' },
      });
      expense.collective = collective;

      paypalLib.getBatchInfo.resolves({
        items: [
          {
            transaction_status: 'SUCCESS',
            payout_item: { sender_item_id: expense.id.toString() },
            payout_batch_id: 'fake-batch-id-eur',
            payout_item_fee: {
              currency: 'EUR',
              value: '1.20',
            },
            currency_conversion: {
              to_amount: { value: '99.312', currency: 'EUR' },
              from_amount: { value: '124.14', currency: 'USD' },
              exchange_rate: '0.80',
            },
          },
        ],
      });

      await paypalPayouts.checkBatchStatus([expense]);
      const [transaction] = await expense.getTransactions({ where: { type: 'DEBIT' } });

      expect(paypalLib.getBatchInfo.getCall(0)).to.have.property('lastArg', 'fake-batch-id-eur');
      expect(expense).to.have.property('status', 'PAID');
      expect(transaction).to.have.property('paymentProcessorFeeInHostCurrency', -150);
      expect(transaction).to.have.property('amountInHostCurrency', -12500);
      expect(transaction).to.have.property('hostCurrency', 'USD');
      expect(transaction).to.have.property('netAmountInCollectiveCurrency', -10120);
      expect(transaction).to.have.property('currency', 'EUR');
    });

    const failedStatuses = ['FAILED', 'BLOCKED', 'REFUNDED', 'RETURNED', 'REVERSED'];
    failedStatuses.map(transaction_status =>
      it(`should set expense status to error if the transaction status is ${transaction_status}`, async () => {
        paypalLib.getBatchInfo.resolves({
          items: [
            {
              transaction_status,
              payout_batch_id: 'fake-batch-id',
              payout_item: { sender_item_id: expense.id.toString() },
            },
          ],
        });
        await paypalPayouts.checkBatchStatus([expense]);
        const transactions = await expense.getTransactions({ where: { type: 'DEBIT' } });

        expect(expense).to.have.property('status', 'ERROR');
        expect(transactions).to.have.length(0);
      }),
    );
  });
});
