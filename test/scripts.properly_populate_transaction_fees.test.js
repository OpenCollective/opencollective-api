import { expect } from 'chai';
import { Migration } from '../scripts/properly_populate_transaction_fees';

describe('Migration', () => {
  describe('#saveTransactionChange', () => {
    it('should create a new change within the data field', () => {
      // Given a transaction with an empty data field
      const transaction = { data: null };

      // When a new change is added
      (new Migration).saveTransactionChange(transaction, 'hostCurrencyFxRate', null, 1);

      // Then the data field should reflect that update
      expect(transaction.data).to.have.property('migration');
      expect(transaction.data.migration).to.have.property('hostCurrencyFxRate');
      expect(transaction.data.migration.hostCurrencyFxRate).to.deep.equal({ oldValue: null, newValue: 1 });
    });

    it('should not override previously created fields', () => {
      // Given a transaction with a data field that contains a
      // migration field
      const transaction = { data: { migration: { hostCurrencyFxRate: { oldValue: null, newValue: 1 } } } };

      // When a new field is added
      (new Migration).saveTransactionChange(transaction, 'platformFeeInHostCurrency', 1082, 1083);

      // Then both fields should be saved in the data.migration property
      expect(transaction.data).to.have.property('migration');
      expect(transaction.data.migration).to.have.property('hostCurrencyFxRate');
      expect(transaction.data.migration.hostCurrencyFxRate).to.deep.equal({ oldValue: null, newValue: 1 });
      expect(transaction.data.migration).to.have.property('platformFeeInHostCurrency');
      expect(transaction.data.migration.platformFeeInHostCurrency).to.deep.equal({ oldValue: 1082, newValue: 1083 });
    });
  });
  describe('#toNegative', () => {
    it('should convert positive numbers to negative', () => {
      expect((new Migration).toNegative(10)).to.equal(-10);
    });
    it('should not do anything with negative numbers', () => {
      expect((new Migration).toNegative(-10)).to.equal(-10);
    });
  });
  describe('#ensureHostCurrencyFxRate', () => {
    it('should not touch transactions that contain a hostCurrencyFxRate value', () => {
      // Given a transaction *with a value* for hostCurrencyFxRate
      const transaction = { hostCurrencyFxRate: 1.5 };

      // When we call the function that ensures the value exists
      (new Migration).ensureHostCurrencyFxRate(transaction);

      // Then nothing changes in the transaction.hostCurrencyFxRate
      // value
      expect(transaction.hostCurrencyFxRate).to.equal(1.5);
    });
    it('should not touch transactions between different currencies', () => {
      // Given a transaction between different currencies
      const transaction = { currency: 'MXN', hostCurrency: 'USD', hostCurrencyFxRate: 18.2 };
      // when we call the function to that the value exists
      (new Migration).ensureHostCurrencyFxRate(transaction);
      // Then we see that nothing is done to hostCurrencyFxRate
      expect(transaction.hostCurrencyFxRate).to.equal(18.2);
    });
    it('should not touch transactions that amount is different from amountInHostCurrency', () => {
      // Given a transaction with amount different from amountInHostCurrency
      const transaction = { amount: 10, amountInHostCurrency: 20, hostCurrencyFxRate: 2 };
      // when we call the function to that the value exists
      (new Migration).ensureHostCurrencyFxRate(transaction);
      // Then we see that nothing is done to hostCurrencyFxRate
      expect(transaction.hostCurrencyFxRate).to.equal(2);
    });
  });
  describe('#rewriteFees', () => {
    it('should find hostFeeInHostCurrency in the credit transaction & ensure it is negative in both credit & debit', () => {
      // Given a credit and a debit transactions
      const [credit1, debit1] = [
        { hostFeeInHostCurrency: 250 },
        { hostFeeInHostCurrency: 0 },
      ];
      const [credit2, debit2] = [
        { hostFeeInHostCurrency: null },
        { hostFeeInHostCurrency: 250 },
      ];

      // When the fee is rewritten
      (new Migration).rewriteFees(credit1, debit1);
      (new Migration).rewriteFees(credit2, debit2);

      // Then we see that both hostFeeInHostCurrency values are
      // negative
      expect(credit1.hostFeeInHostCurrency).to.equal(-250);
      expect(debit1.hostFeeInHostCurrency).to.equal(-250);
      expect(credit1.data.migration).to.deep.equal({ hostFeeInHostCurrency: { oldValue: 250, newValue: -250 } });
      expect(debit1.data.migration).to.deep.equal({ hostFeeInHostCurrency: { oldValue: 0, newValue: -250 } });

      expect(credit2.hostFeeInHostCurrency).to.equal(-250);
      expect(debit2.hostFeeInHostCurrency).to.equal(-250);
      expect(credit2.data.migration).to.deep.equal({ hostFeeInHostCurrency: { oldValue: null, newValue: -250 } });
      expect(debit2.data.migration).to.deep.equal({ hostFeeInHostCurrency: { oldValue: 250, newValue: -250 } });
    });
    it('should find platformFeeInHostCurrency in the credit transaction & ensure it is negative in both credit & debit', () => {
      // Given a credit and a debit transactions
      const [credit1, debit1] = [
        { platformFeeInHostCurrency: 250 },
        { platformFeeInHostCurrency: 0 },
      ];
      const [credit2, debit2] = [
        { platformFeeInHostCurrency: null },
        { platformFeeInHostCurrency: 250 },
      ];

      // When the fee is rewritten
      (new Migration).rewriteFees(credit1, debit1);
      (new Migration).rewriteFees(credit2, debit2);

      // Then we see that both platformFeeInHostCurrency values are
      // negative
      expect(credit1.platformFeeInHostCurrency).to.equal(-250);
      expect(debit1.platformFeeInHostCurrency).to.equal(-250);
      expect(credit1.data.migration).to.deep.equal({ platformFeeInHostCurrency: { oldValue: 250, newValue: -250 } });
      expect(debit1.data.migration).to.deep.equal({ platformFeeInHostCurrency: { oldValue: 0, newValue: -250 } });

      expect(credit2.platformFeeInHostCurrency).to.equal(-250);
      expect(debit2.platformFeeInHostCurrency).to.equal(-250);
      expect(credit2.data.migration).to.deep.equal({ platformFeeInHostCurrency: { oldValue: null, newValue: -250 } });
      expect(debit2.data.migration).to.deep.equal({ platformFeeInHostCurrency: { oldValue: 250, newValue: -250 } });
    });
    it('should find paymentProcessorFeeInHostCurrency in the credit transaction & ensure it is negative in both credit & debit', () => {
      // Given a credit and a debit transactions
      const [credit1, debit1] = [
        { paymentProcessorFeeInHostCurrency: 250 },
        { paymentProcessorFeeInHostCurrency: 0 },
      ];
      const [credit2, debit2] = [
        { paymentProcessorFeeInHostCurrency: null },
        { paymentProcessorFeeInHostCurrency: 250 },
      ];

      // When the fee is rewritten
      (new Migration).rewriteFees(credit1, debit1);
      (new Migration).rewriteFees(credit2, debit2);

      // Then we see that both paymentProcessorFeeInHostCurrency
      // values are negative
      expect(credit1.paymentProcessorFeeInHostCurrency).to.equal(-250);
      expect(debit1.paymentProcessorFeeInHostCurrency).to.equal(-250);
      expect(credit1.data.migration).to.deep.equal({ paymentProcessorFeeInHostCurrency: { oldValue: 250, newValue: -250 } });
      expect(debit1.data.migration).to.deep.equal({ paymentProcessorFeeInHostCurrency: { oldValue: 0, newValue: -250 } });

      expect(credit2.paymentProcessorFeeInHostCurrency).to.equal(-250);
      expect(debit2.paymentProcessorFeeInHostCurrency).to.equal(-250);
      expect(credit2.data.migration).to.deep.equal({ paymentProcessorFeeInHostCurrency: { oldValue: null, newValue: -250 } });
      expect(debit2.data.migration).to.deep.equal({ paymentProcessorFeeInHostCurrency: { oldValue: 250, newValue: -250 } });
    });
  });
  describe('#recalculatePlatformFee', () => {
    it('should recalculate the platform fee making sure it is properly round up', () => {
      // Given a transaction that has the platformFeeInHostCurrency
      // off because of a rounding error (one case for credit & one
      // for debit)
      const [credit1, debit1] = [
        { platformFeeInHostCurrency: 1082, amountInHostCurrency: 21650 },
        { platformFeeInHostCurrency: 0 },
      ];
      const [credit2, debit2] = [
        { platformFeeInHostCurrency: 0, amountInHostCurrency: 21650 },
        { platformFeeInHostCurrency: 1082 },
      ];

      // When the fee is recalculated
      (new Migration).recalculatePlatformFee(credit1, debit1);
      (new Migration).recalculatePlatformFee(credit2, debit2);

      // Then we see that both platformFeeInHostCurrency values were
      // fixed
      expect(credit1.platformFeeInHostCurrency).to.equal(-1083);
      expect(debit1.platformFeeInHostCurrency).to.equal(-1083);
      expect(credit1.data.migration).to.deep.equal({ platformFeeInHostCurrency: { oldValue: 1082, newValue: -1083 } });
      expect(debit1.data.migration).to.deep.equal({ platformFeeInHostCurrency: { oldValue: 0, newValue: -1083 } });

      expect(credit2.platformFeeInHostCurrency).to.equal(-1083);
      expect(debit2.platformFeeInHostCurrency).to.equal(-1083);
      expect(credit2.data.migration).to.deep.equal({ platformFeeInHostCurrency: { oldValue: 0, newValue: -1083 } });
      expect(debit2.data.migration).to.deep.equal({ platformFeeInHostCurrency: { oldValue: 1082, newValue: -1083 } });
    });
  });
  describe('#recalculateHostFee', () => {
    it('should recalculate the host fee from credit', () => {
      // Given a transaction that has the hostFeeInHostCurrency off
      // because of a rounding error
      const [credit1, debit1] = [
        { hostFeeInHostCurrency: 1082, amountInHostCurrency: 21650, collective: { hostFeePercent: 5 } },
        { hostFeeInHostCurrency: 0 },
      ];
      const [credit2, debit2] = [
        { hostFeeInHostCurrency: 0, amountInHostCurrency: 21650, collective: { hostFeePercent: 5 } },
        { hostFeeInHostCurrency: 1082 },
      ];

      // When the fee is recalculated
      (new Migration).recalculateHostFee(credit1, debit1);
      (new Migration).recalculateHostFee(credit2, debit2);

      // Then we see that both hostFeeInHostCurrency values were
      // fixed
      expect(credit1.hostFeeInHostCurrency).to.equal(-1083);
      expect(debit1.hostFeeInHostCurrency).to.equal(-1083);
      expect(credit1.data.migration).to.deep.equal({ hostFeeInHostCurrency: { oldValue: 1082, newValue: -1083 } });
      expect(debit1.data.migration).to.deep.equal({ hostFeeInHostCurrency: { oldValue: 0, newValue: -1083 } });

      expect(credit2.hostFeeInHostCurrency).to.equal(-1083);
      expect(debit2.hostFeeInHostCurrency).to.equal(-1083);
      expect(credit2.data.migration).to.deep.equal({ hostFeeInHostCurrency: { oldValue: 0, newValue: -1083 } });
      expect(debit2.data.migration).to.deep.equal({ hostFeeInHostCurrency: { oldValue: 1082, newValue: -1083 } });
    });
  });
});
