#!/usr/bin/env node

import '../../server/env';

import { groupBy, values } from 'lodash';

import status from '../../server/constants/expense_status';
import logger from '../../server/lib/logger';
import models from '../../server/models';
import { PayoutMethodTypes } from '../../server/models/PayoutMethod';
import * as paypal from '../../server/paymentProviders/paypal/payouts';

export async function run() {
  const expenses = await models.Expense.findAll({
    where: {
      status: status.SCHEDULED_FOR_PAYMENT,
    },
    include: [
      { model: models.Collective, as: 'collective' },
      { model: models.PayoutMethod, as: 'PayoutMethod', where: { type: PayoutMethodTypes.PAYPAL } },
    ],
  });
  const batches = values(groupBy(expenses, 'collective.HostCollectiveId'));
  logger.info(`Processing ${expenses.length} expense(s) scheduled for payment using PayPal Payouts...`);
  for (const batch of batches) {
    logger.info(`Paying host ${batch[0]?.collective?.HostCollectiveId} batch with ${batch.length} expense(s)...`);
    await paypal.payExpensesBatch(batch).catch(console.error);
  }
  logger.info('Done!');
}

if (require.main === module) {
  run()
    .then(() => {
      process.exit(0);
    })
    .catch(e => {
      console.error(e);
      process.exit(1);
    });
}
