'use strict';

module.exports = {
  up: async (queryInterface, Sequelize) => {
    // 1. Add the 'kind' column on Transactions table
    await queryInterface.addColumn('Transactions', 'kind', {
      allowNull: true,
      type: Sequelize.ENUM(
        'ADDED_FUNDS',
        'CONTRIBUTION',
        'EXPENSE',
        'HOST_FEE',
        'HOST_FEE_SHARE',
        'PAYMENT_PROCESSOR_FEE',
        'PLATFORM_FEE',
        'PLATFORM_TIP',
      ),
    });

    // 2. Pre-fill the 'kind' columns everywhere we can
    // ADDED_FUNDS
    await queryInterface.sequelize.query(`
      UPDATE "Transactions" t
      SET "kind" = 'ADDED_FUNDS'
      FROM "PaymentMethods" pm
      WHERE t."PaymentMethodId" = pm.id
      AND pm.service = 'opencollective'
      AND pm."type" = 'host'
    `);

    // CONTRIBUTION
    // This will set KIND=CONTRIBUTION on all Transactions with an order, except for the ones
    // we already migrated above (added funds) and prepaid budgets (tier #15445).
    await queryInterface.sequelize.query(`
      UPDATE "Transactions" t
      SET "kind" = 'CONTRIBUTION'
      FROM "Orders" o
      WHERE t."OrderId" IS NOT NULL
      AND t."OrderId" = o.id
      AND o."TierId" != 15445
      AND "kind" IS NULL
    `);

    // EXPENSE
    await queryInterface.sequelize.query(`
      UPDATE "Transactions" 
      SET "kind" = 'EXPENSE'
      WHERE "ExpenseId" IS NOT NULL
    `);

    // PLATFORM_TIP
    await queryInterface.sequelize.query(`
      UPDATE "Transactions"
      SET "kind" = 'PLATFORM_TIP'
      WHERE ("FromCollectiveId" = 8686 OR "CollectiveId" = 8686)
      AND ("data" ->> 'isFeesOnTop')::boolean = TRUE
    `);
  },

  down: async queryInterface => {
    await queryInterface.removeColumn('Transactions', 'kind');
  },
};
