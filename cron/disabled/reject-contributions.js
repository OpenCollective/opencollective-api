#!/usr/bin/env node
import '../../server/env';

import { ArgumentParser } from 'argparse';
import { get, intersection } from 'lodash';

import { MODERATION_CATEGORIES_ALIASES } from '../../server/constants/moderation-categories';
import orderStatus from '../../server/constants/order_status';
import { purgeCacheForCollective } from '../../server/lib/cache';
import logger from '../../server/lib/logger';
import { notifyAdminsOfCollective } from '../../server/lib/notifications';
import * as libPayments from '../../server/lib/payments';
import models, { Op, sequelize } from '../../server/models';

// Fetch all orders potentially affected: contributor flagged AND recipient setup rejection

const query = `SELECT "Orders"."id"
  FROM "Orders", "Collectives", "Collectives" as "FromCollectives"
  WHERE "Orders"."CollectiveId" = "Collectives"."id" AND "FromCollectives"."id" = "Orders"."FromCollectiveId"
  AND "Orders"."status" = 'ACTIVE'
  AND "Collectives"."settings"->'moderation'->'rejectedCategories' IS NOT NULL
  AND "FromCollectives"."data"->'categories' IS NOT NULL`;

const getContributorRejectedCategories = (fromCollective, collective) => {
  const rejectedCategories = get(collective, 'settings.moderation.rejectedCategories', []);
  const contributorCategories = get(fromCollective, 'data.categories', []);

  if (rejectedCategories.length === 0 || contributorCategories.length === 0) {
    return [];
  }

  // Example:
  // MODERATION_CATEGORIES_ALIASES = ['CASINO_GAMBLING': ['casino', 'gambling'], 'VPN_PROXY': ['vpn', 'proxy']]
  // - when contributorCategories = ['CASINO_GAMBLING'], returns ['CASINO_GAMBLING']
  // - when contributorCategories = ['vpn'] or ['proxy'], returns ['VPN_PROXY']
  const contributorRejectedCategories = Object.keys(MODERATION_CATEGORIES_ALIASES).filter(key => {
    return (
      contributorCategories.includes(key) ||
      intersection(MODERATION_CATEGORIES_ALIASES[key], contributorCategories).length !== 0
    );
  });

  return intersection(rejectedCategories, contributorRejectedCategories);
};

async function run({ dryRun = false } = {}) {
  const rows = await sequelize.query(query, { type: sequelize.QueryTypes.SELECT });

  for (const row of rows) {
    const order = await models.Order.findByPk(row['id']);
    const collective = await models.Collective.findByPk(order.CollectiveId);
    const fromCollective = await models.Collective.findByPk(order.FromCollectiveId);

    logger.info(`Checking order #${order.id} from #${fromCollective.slug} to #${collective.slug}`);

    const rejectedCategories = getContributorRejectedCategories(fromCollective, collective);

    if (rejectedCategories.length === 0) {
      logger.info(`  - No rejected categories`);
      continue;
    }

    logger.info(`  - Found rejected categories: ${rejectedCategories.join(', ')}`);

    // Retrieve latest transaction
    const transaction = await models.Transaction.findOne({
      where: {
        OrderId: order.id,
        type: 'CREDIT',
        createdAt: { [Op.gte]: sequelize.literal("NOW() - INTERVAL '30 days'") },
      },
      order: [['createdAt', 'DESC']],
    });

    if (transaction) {
      logger.info(`  - Found transaction #${transaction.id}`);
      // Refund transaction if not already refunded
      if (!transaction.RefundTransactionId) {
        if (!dryRun) {
          logger.info(`  - Refunding transaction`);
          await libPayments.refundTransaction(transaction);
        }
      } else {
        logger.info(`  - Transaction already refunded`);
      }
    } else {
      logger.info(`  - No transaction found`);
    }

    // Mark the Order as rejected
    logger.info(`  - Marking order #${order.id} as rejected `);
    if (!dryRun) {
      await order.update({ status: orderStatus.REJECTED });
    }

    // Deactivate subscription

    if (order.SubscriptionId) {
      const subscription = await models.Subscription.findByPk(order.SubscriptionId);
      if (subscription) {
        logger.info(`  - Deactivating subscription #${order.SubscriptionId}`);
        if (!dryRun) {
          await subscription.deactivate();
        }
      } else {
        logger.info(`  - Subscription not found`);
      }
    } else {
      logger.info(`  - No subscription to deactivate`);
    }

    // Remove memberships
    logger.info(`  - Deleting BACKER membership`);
    if (!dryRun) {
      await models.Member.destroy({
        where: {
          MemberCollectiveId: fromCollective.id,
          CollectiveId: collective.id,
          role: 'BACKER',
        },
      });
    }

    logger.info(`  - Purging cache for ${collective.slug}`);
    logger.info(`  - Purging cache for ${fromCollective.slug}`);
    if (!dryRun) {
      purgeCacheForCollective(collective);
      purgeCacheForCollective(fromCollective);
    }

    const activity = {
      type: 'contribution.rejected',
      data: { collective: { name: collective.name } },
    };

    logger.info(`  - Notifying admins of ${fromCollective.slug}`);
    if (!dryRun) {
      await notifyAdminsOfCollective(fromCollective.id, activity);
    }
  }
}

/* eslint-disable camelcase */
function parseCommandLineArguments() {
  const parser = new ArgumentParser({
    add_help: true,
    description: 'Reject Contributions based on Categories',
  });
  parser.add_argument('--dryrun', {
    help: "Don't perform any change, just log.",
    default: false,
    action: 'store_const',
    const: true,
  });
  const args = parser.parse_args();
  return {
    dryRun: args.dryrun,
  };
}

/* eslint-enable camelcase */

if (require.main === module) {
  run(parseCommandLineArguments())
    .then(() => {
      process.exit(0);
    })
    .catch(e => {
      console.error(e);
      process.exit(1);
    });
}
