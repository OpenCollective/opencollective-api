import {
  GraphQLBoolean,
  GraphQLEnumType,
  GraphQLInt,
  GraphQLInterfaceType,
  GraphQLList,
  GraphQLNonNull,
  GraphQLObjectType,
  GraphQLString,
} from 'graphql';
import GraphQLJSON from 'graphql-type-json';
import { get, has, sortBy } from 'lodash';
import moment from 'moment';
import sequelize from 'sequelize';
import SqlString from 'sequelize/lib/sql-string';

import { types } from '../../constants/collectives';
import FEATURE from '../../constants/feature';
import FEATURE_STATUS from '../../constants/feature-status';
import roles from '../../constants/roles';
import { getContributorsForCollective } from '../../lib/contributors';
import queries from '../../lib/queries';
import models, { Op } from '../../models';
import { hostResolver } from '../common/collective';
import { getContextPermission, PERMISSION_TYPE } from '../common/context-permissions';
import { getFeatureStatusResolver } from '../common/features';

import { ApplicationType } from './Application';
import { TransactionInterfaceType } from './TransactionInterface';
import {
  ConnectedAccountType,
  ContributorRoleEnum,
  ContributorType,
  DateString,
  ExpenseType,
  ImageFormatType,
  LocationType,
  MemberType,
  NotificationType,
  OrderDirectionType,
  OrderStatusType,
  OrderType,
  PaginatedPaymentMethodsType,
  PaymentMethodBatchInfo,
  PaymentMethodType,
  PayoutMethodType,
  TierType,
  UpdateType,
  UserType,
} from './types';

export const TypeOfCollectiveType = new GraphQLEnumType({
  name: 'TypeOfCollective',
  values: {
    COLLECTIVE: {},
    EVENT: {},
    ORGANIZATION: {},
    USER: {},
    BOT: {},
  },
});

export const CollectiveOrderFieldType = new GraphQLEnumType({
  name: 'CollectiveOrderField',
  description: 'Properties by which collectives can be ordered.',
  values: {
    monthlySpending: {
      description: 'Order collectives by their average monthly spending (based on last 90 days)',
    },
    balance: {
      description: 'Order collectives by total balance.',
    },
    createdAt: {
      description: 'Order collectives by creation time.',
    },
    name: {
      description: 'Order collectives by name.',
    },
    slug: {
      description: 'Order collectives by slug.',
    },
    updatedAt: {
      description: 'Order collectives by updated time.',
    },
    totalDonations: {
      description: 'Order collectives by total donations.',
    },
  },
});

export const PaymentMethodOrderFieldType = new GraphQLEnumType({
  name: 'PaymenMethodOrderField',
  description: 'Properties by which PaymenMethods can be ordered',
  values: {
    type: {
      description: 'Order payment methods by type (creditcard, virtualcard...)',
    },
  },
});

export const HostCollectiveOrderFieldType = new GraphQLEnumType({
  name: 'HostCollectiveOrderFieldType',
  description: 'Properties by which hosts can be ordered.',
  values: {
    createdAt: {
      description: 'Order hosts by creation time.',
    },
    name: {
      description: 'Order hosts by name.',
    },
    collectives: {
      description: 'Order hosts by number of collectives it is hosting.',
    },
    updatedAt: {
      description: 'Order hosts by updated time.',
    },
  },
});

export const BackersStatsType = new GraphQLObjectType({
  name: 'BackersStatsType',
  description: 'Breakdown of backers per type (ANY/USER/ORGANIZATION/COLLECTIVE)',
  fields: () => {
    return {
      // We always have to return an id for apollo's caching
      id: {
        type: GraphQLInt,
        resolve(stats) {
          return stats.id;
        },
      },
      all: {
        description: 'Total number of backers that have given money to this collective',
        type: GraphQLInt,
        resolve(stats) {
          return stats.all;
        },
      },
      users: {
        description: 'Number of individuals that have given money to this collective',
        type: GraphQLInt,
        resolve(stats) {
          return stats.USER || 0;
        },
      },
      organizations: {
        description: 'Number of organizations that have given money to this collective',
        type: GraphQLInt,
        resolve(stats) {
          return stats.ORGANIZATION || 0;
        },
      },
      collectives: {
        description: 'Number of collectives that have given money to this collective',
        type: GraphQLInt,
        resolve(stats) {
          return stats.COLLECTIVE || 0;
        },
      },
    };
  },
});

export const CollectivesStatsType = new GraphQLObjectType({
  name: 'CollectivesStatsType',
  description: 'Breakdown of collectives under this collective by role (all/hosted/memberOf/events)',
  fields: () => {
    return {
      // We always have to return an id for apollo's caching
      id: {
        type: GraphQLInt,
        resolve(collective) {
          return collective.id;
        },
      },
      all: {
        type: GraphQLInt,
        async resolve(collective) {
          return models.Collective.count({
            where: {
              [Op.or]: {
                ParentCollectiveId: collective.id,
                HostCollectiveId: collective.id,
              },
              isActive: true,
            },
          });
        },
      },
      hosted: {
        type: GraphQLInt,
        description: 'Returns the collectives hosted by this collective',
        async resolve(collective) {
          return models.Member.count({
            where: {
              MemberCollectiveId: collective.id,
              role: roles.HOST,
            },
            include: [
              {
                model: models.Collective,
                as: 'collective',
                where: { type: types.COLLECTIVE, isActive: true },
              },
            ],
          });
        },
      },
      memberOf: {
        type: GraphQLInt,
        description: 'Returns the number of collectives that have this collective has parent',
        async resolve(collective) {
          return models.Collective.count({
            where: {
              ParentCollectiveId: collective.id,
              type: [types.COLLECTIVE, types.ORGANIZATION],
              isActive: true,
            },
          });
        },
      },
      events: {
        type: GraphQLInt,
        description: 'Returns the number of events that have this collective has parent',
        async resolve(collective) {
          return models.Collective.count({
            where: {
              ParentCollectiveId: collective.id,
              type: types.EVENT,
              isActive: true,
            },
          });
        },
      },
    };
  },
});

export const PlanType = new GraphQLObjectType({
  name: 'PlanType',
  description: 'The name of the current plan and its characteristics.',
  fields: {
    name: {
      type: GraphQLString,
    },
    hostedCollectives: {
      type: GraphQLInt,
    },
    hostedCollectivesLimit: {
      type: GraphQLInt,
    },
    addedFunds: {
      type: GraphQLInt,
    },
    addedFundsLimit: {
      type: GraphQLInt,
    },
    hostDashboard: {
      type: GraphQLBoolean,
    },
    manualPayments: {
      type: GraphQLBoolean,
    },
    bankTransfers: {
      type: GraphQLInt,
    },
    bankTransfersLimit: {
      type: GraphQLInt,
    },
    transferwisePayouts: {
      type: GraphQLInt,
    },
    transferwisePayoutsLimit: {
      type: GraphQLInt,
    },
  },
});

export const ExpensesStatsType = new GraphQLObjectType({
  name: 'ExpensesStatsType',
  description: 'Breakdown of expenses per status (ALL/PENDING/APPROVED/PAID/REJECTED)',
  fields: () => {
    return {
      // We always have to return an id for apollo's caching
      id: {
        type: GraphQLInt,
        resolve(collective) {
          return collective.id;
        },
      },
      all: {
        type: GraphQLInt,
        async resolve(collective, args, req) {
          const expenses = (await req.loaders.Collective.stats.expenses.load(collective.id)) || {};
          let count = 0;
          Object.keys(expenses).forEach(status => (count += (status !== 'CollectiveId' && expenses[status]) || 0));
          return count;
        },
      },
      pending: {
        type: GraphQLInt,
        description: 'Returns the number of expenses that are pending',
        async resolve(collective, args, req) {
          const expenses = (await req.loaders.Collective.stats.expenses.load(collective.id)) || {};
          return expenses.PENDING || 0;
        },
      },
      approved: {
        type: GraphQLInt,
        description: 'Returns the number of expenses that are approved',
        async resolve(collective, args, req) {
          const expenses = (await req.loaders.Collective.stats.expenses.load(collective.id)) || {};
          return expenses.APPROVED || 0;
        },
      },
      rejected: {
        type: GraphQLInt,
        description: 'Returns the number of expenses that are rejected',
        async resolve(collective, args, req) {
          const expenses = (await req.loaders.Collective.stats.expenses.load(collective.id)) || {};
          return expenses.REJECTED || 0;
        },
      },
      paid: {
        type: GraphQLInt,
        description: 'Returns the number of expenses that are paid',
        async resolve(collective, args, req) {
          const expenses = (await req.loaders.Collective.stats.expenses.load(collective.id)) || {};
          return expenses.PAID || 0;
        },
      },
    };
  },
});

export const TransactionsStatsType = new GraphQLObjectType({
  name: 'TransactionsStatsType',
  description: 'Breakdown of transactions per type (ALL/CREDIT/DEBIT)',
  fields: () => {
    return {
      // We always have to return an id for apollo's caching
      id: {
        type: GraphQLInt,
        resolve(collective) {
          return collective.id;
        },
      },
      all: {
        type: GraphQLInt,
        resolve(collective) {
          return models.Transaction.count({
            where: { CollectiveId: collective.id },
          });
        },
      },
      credit: {
        type: GraphQLInt,
        description: 'Returns the number of CREDIT transactions',
        resolve(collective) {
          return models.Transaction.count({
            where: { CollectiveId: collective.id, type: 'CREDIT' },
          });
        },
      },
      debit: {
        type: GraphQLInt,
        description: 'Returns the number of DEBIT transactions',
        async resolve(collective) {
          return models.Transaction.count({
            where: { CollectiveId: collective.id, type: 'DEBIT' },
          });
        },
      },
    };
  },
});

export const CollectiveStatsType = new GraphQLObjectType({
  name: 'CollectiveStatsType',
  description: 'Stats for the collective',
  fields: () => {
    return {
      // We always have to return an id for apollo's caching
      id: {
        type: GraphQLInt,
        resolve(collective) {
          return collective.id;
        },
      },
      balance: {
        description: 'Amount of money in cents in the currency of the collective currently available to spend',
        type: GraphQLInt,
        resolve(collective, args, req) {
          return req.loaders.Collective.balance.load(collective.id);
        },
      },
      backers: {
        description: 'Breakdown of all backers of this collective',
        type: BackersStatsType,
        resolve(collective, args, req) {
          return req.loaders.Collective.stats.backers.load(collective.id);
        },
      },
      collectives: {
        description: 'Number of collectives under this collective',
        type: CollectivesStatsType,
        resolve(collective) {
          return collective;
        },
      },
      updates: {
        description: 'Number of updates published by this collective',
        type: GraphQLInt,
        resolve(collective) {
          return models.Update.count({
            where: {
              CollectiveId: collective.id,
              publishedAt: { [Op.ne]: null },
            },
          });
        },
      },
      events: {
        description: 'Number of events under this collective',
        type: GraphQLInt,
        resolve(collective) {
          return models.Collective.count({
            where: { ParentCollectiveId: collective.id, type: types.EVENT },
          });
        },
      },
      expenses: {
        description: 'Breakdown of expenses submitted to this collective by type (ALL/PENDING/APPROVED/PAID/REJECTED)',
        type: ExpensesStatsType,
        resolve(collective) {
          return collective;
        },
      },
      transactions: {
        description: 'Number of transactions',
        type: TransactionsStatsType,
        resolve(collective) {
          return collective;
        },
      },
      monthlySpending: {
        description: 'Average amount spent per month based on the last 90 days',
        type: GraphQLInt,
        resolve(collective) {
          // if we fetched the collective with the raw query to sort them by their monthly spending we don't need to recompute it
          if (has(collective, 'dataValues.monthlySpending')) {
            return get(collective, 'dataValues.monthlySpending');
          } else {
            return collective.getMonthlySpending();
          }
        },
      },
      totalAmountSpent: {
        description: 'Total amount spent',
        type: GraphQLInt,
        resolve(collective) {
          return collective.getTotalAmountSpent();
        },
      },
      totalAmountReceived: {
        description: 'Net amount received',
        type: GraphQLInt,
        args: {
          startDate: { type: DateString },
          endDate: { type: DateString },
          periodInMonths: {
            type: GraphQLInt,
            description: 'Computes contributions from the last x months. Cannot be used with startDate/endDate',
          },
        },
        resolve(collective, args) {
          let startDate = args.startDate ? new Date(args.startDate) : null;
          let endDate = args.endDate ? new Date(args.endDate) : null;

          if (args.periodInMonths) {
            startDate = moment().subtract(args.periodInMonths, 'months').seconds(0).milliseconds(0).toDate();
            endDate = null;
          }

          return collective.getTotalAmountReceived(startDate, endDate);
        },
      },
      yearlyBudget: {
        type: GraphQLInt,
        resolve(collective) {
          return collective.getYearlyIncome();
        },
      },
      yearlyBudgetManaged: {
        type: GraphQLInt,
        resolve(collective) {
          if (collective.isHostAccount) {
            return queries.getTotalAnnualBudgetForHost(collective.id);
          } else {
            return 0;
          }
        },
      },
      topExpenses: {
        type: GraphQLJSON,
        resolve(collective) {
          return Promise.all([
            queries.getTopExpenseCategories(collective.id),
            queries.getTopExpenseSubmitters(collective.id),
          ]).then(results => {
            const res = {
              byCategory: results[0],
              byCollective: results[1],
            };
            return res;
          });
        },
      },
      topFundingSources: {
        type: GraphQLJSON,
        resolve(collective) {
          return Promise.all([
            queries.getTopDonorsForCollective(collective.id),
            queries.getTotalDonationsByCollectiveType(collective.id),
          ]).then(results => {
            const res = {
              byCollective: results[0],
              byCollectiveType: results[1],
            };
            return res;
          });
        },
      },
      activeRecurringContributions: {
        type: GraphQLJSON,
        resolve(collective, args, req) {
          return req.loaders.Collective.stats.activeRecurringContributions.load(collective.id);
        },
      },
    };
  },
});

export const CollectiveInterfaceType = new GraphQLInterfaceType({
  name: 'CollectiveInterface',
  description: 'Collective interface',
  resolveType: collective => {
    switch (collective.type) {
      case types.COLLECTIVE:
      case types.BOT:
        return CollectiveType;

      case types.USER:
        return UserCollectiveType;

      case types.ORGANIZATION:
        return OrganizationCollectiveType;

      case types.EVENT:
        return EventCollectiveType;

      default:
        return null;
    }
  },
  fields: () => {
    return {
      id: { type: GraphQLInt },
      createdByUser: { type: UserType },
      parentCollective: { type: CollectiveInterfaceType },
      type: { type: GraphQLString },
      isActive: { type: GraphQLBoolean },
      name: { type: GraphQLString },
      company: { type: GraphQLString },
      description: { type: GraphQLString },
      longDescription: { type: GraphQLString },
      hasLongDescription: {
        type: GraphQLBoolean,
        description: 'Returns true if the collective has a long description',
      },
      expensePolicy: { type: GraphQLString },
      mission: { type: GraphQLString },
      tags: { type: new GraphQLList(GraphQLString) },
      location: {
        type: LocationType,
        description: 'Name, address, country, lat, long of the location.',
      },
      createdAt: { type: DateString },
      startsAt: { type: DateString },
      endsAt: { type: DateString },
      timezone: { type: GraphQLString },
      maxAmount: { type: GraphQLInt },
      hostFeePercent: { type: GraphQLInt },
      platformFeePercent: { type: GraphQLInt },
      currency: { type: GraphQLString },
      image: { type: GraphQLString },
      imageUrl: {
        type: GraphQLString,
        args: {
          height: { type: GraphQLInt },
          format: {
            type: ImageFormatType,
          },
        },
      },
      backgroundImage: { type: GraphQLString },
      backgroundImageUrl: {
        type: GraphQLString,
        args: {
          height: { type: GraphQLInt },
          format: {
            type: ImageFormatType,
          },
        },
      },
      settings: { type: GraphQLJSON },
      isPledged: {
        description: 'Defines if a collective is pledged',
        type: GraphQLBoolean,
      },
      data: { type: GraphQLJSON },
      slug: { type: GraphQLString },
      path: { type: GraphQLString },
      isHost: { type: GraphQLBoolean },
      isIncognito: { type: GraphQLBoolean },
      canApply: { type: GraphQLBoolean },
      canContact: { type: GraphQLBoolean },
      isArchived: { type: GraphQLBoolean },
      isApproved: { type: GraphQLBoolean },
      isDeletable: { type: GraphQLBoolean },
      host: { type: CollectiveInterfaceType },
      hostCollective: { type: CollectiveInterfaceType },
      members: {
        type: new GraphQLList(MemberType),
        description:
          'List of all collectives that are related to this collective with their membership relationship. Can filter by role (BACKER/MEMBER/ADMIN/HOST/FOLLOWER)',
        args: {
          limit: { type: GraphQLInt },
          offset: { type: GraphQLInt },
          type: {
            type: GraphQLString,
            description: 'Type of User: USER/ORGANIZATION',
          },
          TierId: { type: GraphQLInt },
          tierSlug: { type: GraphQLString },
          role: { type: GraphQLString },
          roles: { type: new GraphQLList(GraphQLString) },
        },
      },
      memberOf: {
        type: new GraphQLList(MemberType),
        description:
          'List of all collectives that this collective is a member of with their membership relationship. Can filter by role (BACKER/MEMBER/ADMIN/HOST/FOLLOWER)',
        args: {
          limit: { type: GraphQLInt },
          offset: { type: GraphQLInt },
          type: {
            type: GraphQLString,
            description: 'Type of collective (COLLECTIVE, EVENT, ORGANIZATION)',
          },
          role: { type: GraphQLString },
          roles: { type: new GraphQLList(GraphQLString) },
          onlyActiveCollectives: {
            type: GraphQLBoolean,
            description: 'Only return memberships for active collectives (that have been approved by the host)',
            defaultValue: false,
          },
          includeIncognito: {
            type: GraphQLBoolean,
            defaultValue: true,
            description:
              'Wether incognito profiles should be included in the result. Only works if requesting user is an admin of the account.',
          },
        },
      },
      contributors: {
        type: new GraphQLList(ContributorType),
        description: 'All the persons and entities that contribute to this organization',
        args: {
          limit: { type: GraphQLInt, defaultValue: 1000 },
          roles: { type: new GraphQLList(ContributorRoleEnum) },
        },
      },
      collectives: {
        type: CollectiveSearchResultsType,
        description: 'List of all collectives hosted by this collective',
        args: {
          orderBy: { defaultValue: 'name', type: CollectiveOrderFieldType },
          orderDirection: { defaultValue: 'ASC', type: OrderDirectionType },
          expenseStatus: { defaultValue: null, type: GraphQLString },
          limit: { type: GraphQLInt },
          offset: { type: GraphQLInt },
          isActive: { type: GraphQLBoolean },
          isArchived: { type: GraphQLBoolean },
        },
      },
      followers: {
        type: new GraphQLList(CollectiveInterfaceType),
        description: 'List of all followers of this collective',
        args: {
          limit: { type: GraphQLInt },
          offset: { type: GraphQLInt },
        },
      },
      notifications: {
        type: new GraphQLList(NotificationType),
        description: 'List of all notifications for this collective',
        args: {
          limit: { type: GraphQLInt },
          offset: { type: GraphQLInt },
          channel: { type: GraphQLString },
          type: { type: GraphQLString },
          active: { type: GraphQLBoolean },
        },
      },
      maxQuantity: { type: GraphQLInt },
      tiers: {
        type: new GraphQLList(TierType),
        args: {
          id: { type: GraphQLInt },
          slug: { type: GraphQLString },
          slugs: { type: new GraphQLList(GraphQLString) },
        },
      },
      orders: {
        type: new GraphQLList(OrderType),
        args: {
          status: { type: OrderStatusType },
        },
      },
      ordersFromCollective: {
        type: new GraphQLList(OrderType),
        args: {
          subscriptionsOnly: { type: GraphQLBoolean },
        },
      },
      stats: { type: CollectiveStatsType },
      transactions: {
        type: new GraphQLList(TransactionInterfaceType),
        args: {
          type: { type: GraphQLString },
          limit: { type: GraphQLInt },
          offset: { type: GraphQLInt },
          includeExpenseTransactions: { type: GraphQLBoolean },
        },
      },
      expenses: {
        type: new GraphQLList(ExpenseType),
        args: {
          type: { type: GraphQLString },
          limit: { type: GraphQLInt },
          offset: { type: GraphQLInt },
          status: { type: GraphQLString },
          includeHostedCollectives: { type: GraphQLBoolean },
        },
      },
      role: { type: GraphQLString },
      twitterHandle: { type: GraphQLString },
      githubHandle: { type: GraphQLString },
      website: { type: GraphQLString },
      updates: {
        type: new GraphQLList(UpdateType),
        args: {
          limit: { type: GraphQLInt },
          offset: { type: GraphQLInt },
          onlyPublishedUpdates: { type: GraphQLBoolean },
        },
      },
      events: {
        type: new GraphQLList(EventCollectiveType),
        args: {
          limit: { type: GraphQLInt },
          offset: { type: GraphQLInt },
          includePastEvents: {
            type: GraphQLBoolean,
            defaultValue: false,
            description: 'Include past events',
          },
          includeInactive: {
            type: GraphQLBoolean,
            defaultValue: false,
            description: 'Include inactive events',
          },
        },
      },
      childCollectives: {
        type: new GraphQLList(CollectiveType),
        description: "Get all child collectives (with type=COLLECTIVE, doesn't return events)",
        deprecationReason: '2020/01/08 - Connected-collectives are now handled through members',
      },
      paymentMethods: {
        type: new GraphQLList(PaymentMethodType),
        args: {
          service: { type: GraphQLString },
          limit: { type: GraphQLInt },
          hasBalanceAboveZero: { type: GraphQLBoolean },
          isConfirmed: {
            type: GraphQLBoolean,
            description: 'Only return confirmed payment methods',
            defaultValue: true,
          },
          types: {
            type: new GraphQLList(GraphQLString),
            description: 'Filter on given types (creditcard, virtualcard...)',
          },
          orderBy: {
            type: PaymentMethodOrderFieldType,
            description: 'Order entries based on given column. Set to null for no ordering.',
          },
          includeOrganizationCollectivePaymentMethod: {
            type: GraphQLBoolean,
            defaultValue: false,
            description: 'Defines if the organization "collective" payment method should be returned',
            deprecationReason: '2019-12-20: Replaced by includeHostCollectivePaymentMethod',
          },
          includeHostCollectivePaymentMethod: {
            type: GraphQLBoolean,
            defaultValue: false,
            description: 'Defines if the host "collective" payment method should be returned',
          },
        },
      },
      payoutMethods: {
        type: new GraphQLList(PayoutMethodType),
        description: 'The list of payout methods that this collective can use to get paid',
      },
      virtualCardsBatches: {
        type: new GraphQLList(PaymentMethodBatchInfo),
        description:
          'List all the gift cards batches emitted by this collective. May include `null` as key for unbatched gift cards.',
      },
      createdVirtualCards: {
        type: PaginatedPaymentMethodsType,
        args: {
          limit: { type: GraphQLInt },
          offset: { type: GraphQLInt },
          batch: { type: GraphQLString },
          isConfirmed: {
            type: GraphQLBoolean,
            description: 'Wether the virtual card has been claimed or not',
          },
        },
      },
      connectedAccounts: { type: new GraphQLList(ConnectedAccountType) },
      features: {
        type: new GraphQLNonNull(CollectiveFeatures),
        description: 'Describes the features enabled and available for this collective',
      },
      plan: { type: PlanType },
    };
  },
});

const CollectiveFields = () => {
  return {
    id: {
      type: GraphQLInt,
      resolve(collective) {
        return collective.id;
      },
    },
    createdByUser: {
      type: UserType,
      resolve(collective, args, req) {
        if (
          collective.isIncognito &&
          !getContextPermission(req, PERMISSION_TYPE.SEE_INCOGNITO_ACCOUNT_DETAILS, collective.id)
        ) {
          return {};
        }
        return models.User.findByPk(collective.CreatedByUserId);
      },
    },
    parentCollective: {
      type: CollectiveInterfaceType,
      resolve(collective) {
        return models.Collective.findByPk(collective.ParentCollectiveId);
      },
    },
    type: {
      type: GraphQLString,
      resolve(collective) {
        return collective.type;
      },
    },
    isActive: {
      type: GraphQLBoolean,
      resolve(collective) {
        return collective.isActive;
      },
    },
    name: {
      type: GraphQLString,
      resolve(collective) {
        return collective.name;
      },
    },
    company: {
      type: GraphQLString,
      resolve(collective) {
        return collective.company;
      },
    },
    description: {
      type: GraphQLString,
      resolve(collective) {
        return collective.description;
      },
    },
    longDescription: {
      type: GraphQLString,
      resolve(collective) {
        return collective.longDescription;
      },
    },
    hasLongDescription: {
      type: GraphQLBoolean,
      description: 'Returns true if the collective has a long description',
      resolve(collective) {
        return Boolean(collective.longDescription);
      },
    },
    expensePolicy: {
      type: GraphQLString,
      resolve(collective) {
        return collective.expensePolicy;
      },
    },
    mission: {
      type: GraphQLString,
      resolve(collective) {
        return collective.mission;
      },
    },
    tags: {
      type: new GraphQLList(GraphQLString),
      resolve(collective) {
        return collective.tags;
      },
    },
    location: {
      type: LocationType,
      description: 'Name, address, lat, long of the location.',
      resolve(collective, _, req) {
        const publicAddressesCollectiveTypes = [types.COLLECTIVE, types.EVENT, types.ORGANIZATION];
        if (publicAddressesCollectiveTypes.includes(collective.type)) {
          return collective.location;
        } else if (!req.remoteUser) {
          return null;
        } else if (req.remoteUser.isAdmin(collective.id)) {
          return collective.location;
        } else {
          return req.loaders.Collective.privateInfos.load(collective).then(c => c.location);
        }
      },
    },
    createdAt: {
      type: DateString,
      resolve(collective) {
        return collective.createdAt;
      },
    },
    startsAt: {
      type: DateString,
      resolve(collective) {
        return collective.startsAt;
      },
    },
    endsAt: {
      type: DateString,
      resolve(collective) {
        return collective.endsAt;
      },
    },
    timezone: {
      type: GraphQLString,
      resolve(collective) {
        return collective.timezone;
      },
    },
    maxAmount: {
      type: GraphQLInt,
      resolve(collective) {
        return collective.maxAmount;
      },
    },
    hostFeePercent: {
      type: GraphQLInt,
      resolve(collective) {
        return collective.hostFeePercent;
      },
    },
    platformFeePercent: {
      type: GraphQLInt,
      resolve(collective) {
        return collective.platformFeePercent;
      },
    },
    currency: {
      type: GraphQLString,
      resolve(collective) {
        return collective.currency;
      },
    },
    image: {
      type: GraphQLString,
      async resolve(collective, args, req) {
        if (collective.type === 'EVENT' && !collective.image) {
          const parentCollective = await req.loaders.Collective.byId.load(collective.ParentCollectiveId);
          if (parentCollective) {
            return parentCollective.image;
          }
        }
        return collective.image;
      },
    },
    imageUrl: {
      type: GraphQLString,
      args: {
        height: { type: GraphQLInt },
        format: {
          type: ImageFormatType,
        },
      },
      async resolve(collective, args, req) {
        if (collective.type === 'EVENT' && !collective.image) {
          const parentCollective = await req.loaders.Collective.byId.load(collective.ParentCollectiveId);
          if (parentCollective) {
            return parentCollective.getImageUrl(args);
          }
        }
        return collective.getImageUrl(args);
      },
    },
    backgroundImage: {
      type: GraphQLString,
      resolve(collective) {
        return collective.backgroundImage;
      },
    },
    backgroundImageUrl: {
      type: GraphQLString,
      args: {
        height: { type: GraphQLInt },
        format: {
          type: ImageFormatType,
        },
      },
      resolve(collective, args) {
        return collective.getBackgroundImageUrl(args);
      },
    },
    settings: {
      type: GraphQLJSON,
      resolve(collective) {
        return collective.settings || {};
      },
    },
    isPledged: {
      description: 'Defines if a collective is pledged',
      type: GraphQLBoolean,
      resolve(collective) {
        return collective.isPledged;
      },
    },
    data: {
      type: GraphQLJSON,
      resolve(collective) {
        return collective.data || {};
      },
    },
    slug: {
      type: GraphQLString,
      resolve(collective) {
        return collective.slug;
      },
    },
    path: {
      type: GraphQLString,
      async resolve(collective) {
        return await collective.getUrlPath();
      },
    },
    isHost: {
      description: 'Returns whether this collective can host other collectives (ie. has a Stripe Account connected)',
      type: GraphQLBoolean,
      resolve(collective) {
        return collective.isHost();
      },
    },
    canApply: {
      description: 'Returns whether this host accepts applications for new collectives',
      type: GraphQLBoolean,
      resolve(collective) {
        return collective.canApply();
      },
    },
    canContact: {
      description: 'Returns whether this collectives can be contacted',
      type: GraphQLBoolean,
      resolve(collective) {
        return collective.canContact();
      },
    },
    isIncognito: {
      description: 'Returns whether this collective is incognito',
      type: GraphQLBoolean,
      resolve(collective) {
        return collective.isIncognito;
      },
    },
    isArchived: {
      description: 'Returns whether this collective is archived',
      type: GraphQLBoolean,
      resolve(collective) {
        return Boolean(collective.deactivatedAt && !collective.isActive);
      },
    },
    isApproved: {
      description: 'Returns whether this collective is approved',
      type: GraphQLBoolean,
      async resolve(collective, _, req) {
        if (!collective.HostCollectiveId) {
          return false;
        } else if (collective.type === types.EVENT) {
          const ParentCollectiveId = collective.ParentCollectiveId;
          const parentCollective = ParentCollectiveId && (await req.loaders.Collective.byId.load(ParentCollectiveId));
          // In the future, we should make it possible to directly read the approvedAt of the event
          return parentCollective && (parentCollective.isHostAccount || parentCollective.isApproved());
        } else {
          return collective.isApproved();
        }
      },
    },
    isDeletable: {
      description: 'Returns whether this collective is deletable',
      type: GraphQLBoolean,
      async resolve(collective) {
        const transactionCount = await models.Transaction.count({
          where: {
            [Op.or]: [{ CollectiveId: collective.id }, { FromCollectiveId: collective.id }],
          },
        });
        const orderCount = await models.Order.count({
          where: {
            [Op.or]: [{ CollectiveId: collective.id }, { FromCollectiveId: collective.id }],
          },
        });
        const expenseCount = await models.Expense.count({
          where: { CollectiveId: collective.id, status: 'PAID' },
        });
        const eventCount = await models.Collective.count({
          where: { ParentCollectiveId: collective.id, type: types.EVENT },
        });

        if (transactionCount > 0 || orderCount > 0 || expenseCount > 0 || eventCount > 0) {
          return false;
        }
        return true;
      },
    },
    host: {
      description: 'Get the host collective that is receiving the money on behalf of this collective',
      type: CollectiveInterfaceType,
      resolve: hostResolver,
    },
    hostCollective: {
      description: 'A host might have a collective attached to it',
      type: CollectiveInterfaceType,
      resolve(collective, args, req) {
        if (has(collective.settings, 'hostCollective.id')) {
          return req.loaders.Collective.byId.load(get(collective.settings, 'hostCollective.id'));
        }
        return null;
      },
    },
    members: {
      description: 'Get all the members of this collective (admins, members, backers, followers)',
      type: new GraphQLList(MemberType),
      args: {
        limit: { type: GraphQLInt },
        offset: { type: GraphQLInt },
        type: { type: GraphQLString },
        role: { type: GraphQLString },
        TierId: { type: GraphQLInt },
        tierSlug: { type: GraphQLString },
        roles: { type: new GraphQLList(GraphQLString) },
      },
      resolve(collective, args) {
        const query = {
          limit: args.limit,
          offset: args.offset,
          order: [['id', 'ASC']],
        };

        query.where = { CollectiveId: collective.id };
        if (args.TierId) {
          query.where.TierId = args.TierId;
        }
        const roles = args.roles || (args.role && [args.role]);

        if (roles && roles.length > 0) {
          query.where.role = { [Op.in]: roles };
        }

        let conditionOnMemberCollective;
        if (args.type) {
          const types = args.type.split(',');
          conditionOnMemberCollective = { type: { [Op.in]: types } };
        }

        query.include = [
          {
            model: models.Collective,
            as: 'memberCollective',
            required: true,
            where: conditionOnMemberCollective,
          },
        ];

        if (args.tierSlug) {
          query.include.push({
            model: models.Tier,
            where: { slug: args.tierSlug },
          });
        }

        return models.Member.findAll(query);
      },
    },
    memberOf: {
      description: 'Get all the collective this collective is a member of (as a member, backer, follower, etc.)',
      type: new GraphQLList(MemberType),
      args: {
        limit: { type: GraphQLInt },
        offset: { type: GraphQLInt },
        type: {
          type: GraphQLString,
          description: 'Type of collective (COLLECTIVE, EVENT, ORGANIZATION)',
        },
        role: { type: GraphQLString },
        roles: { type: new GraphQLList(GraphQLString) },
        onlyActiveCollectives: {
          type: GraphQLBoolean,
          description: 'Only return memberships for active collectives (that have been approved by the host)',
          defaultValue: false,
        },
        includeIncognito: {
          type: GraphQLBoolean,
          defaultValue: true,
          description:
            'Wether incognito profiles should be included in the result. Only works if requesting user is an admin of the account.',
        },
      },
      resolve(collective, args, req) {
        const where = { MemberCollectiveId: collective.id };
        const roles = args.roles || (args.role && [args.role]);
        if (roles && roles.length > 0) {
          where.role = { [Op.in]: roles };
        }
        const collectiveConditions = { deletedAt: null };
        if (args.type) {
          collectiveConditions.type = args.type;
        }
        if (args.onlyActiveCollectives) {
          collectiveConditions.isActive = true;
        }
        if (!args.includeIncognito || !req.remoteUser?.isAdmin(collective.id)) {
          collectiveConditions.isIncognito = false;
        }
        return models.Member.findAll({
          where,
          limit: args.limit,
          offset: args.offset,
          include: [
            {
              model: models.Collective,
              as: 'collective',
              where: collectiveConditions,
            },
          ],
        });
      },
    },
    contributors: {
      type: new GraphQLList(ContributorType),
      description: 'All the persons and entities that contribute to this organization',
      args: {
        limit: { type: GraphQLInt, defaultValue: 1000 },
        roles: { type: new GraphQLList(ContributorRoleEnum) },
      },
      resolve(collective, args) {
        return getContributorsForCollective(collective.id, args);
      },
    },
    collectives: {
      type: CollectiveSearchResultsType,
      args: {
        orderBy: { defaultValue: 'name', type: CollectiveOrderFieldType },
        orderDirection: { defaultValue: 'ASC', type: OrderDirectionType },
        expenseStatus: { defaultValue: null, type: GraphQLString },
        limit: { type: GraphQLInt },
        offset: { type: GraphQLInt },
        isActive: { type: GraphQLBoolean },
        isArchived: { type: GraphQLBoolean },
      },
      async resolve(collective, args) {
        const query = {
          where: { HostCollectiveId: collective.id, type: types.COLLECTIVE },
          order: [[args.orderBy, args.orderDirection]],
          limit: args.limit,
          offset: args.offset,
        };

        if (typeof args.isActive !== 'undefined') {
          query.where.isActive = args.isActive;
        } else if (typeof args.isArchived !== 'undefined') {
          query.where.isArchived = args.isArchived;
        }

        /* if any specific Expense status was passed */
        if (args.expenseStatus) {
          /* The escape trick came from here:
             https://github.com/sequelize/sequelize/issues/1132

             Didin't really find a better way to do it. */
          const status = SqlString.escape(args.expenseStatus.toUpperCase());
          query.where.expenseCount = sequelize.where(
            /* This tests if collective has any expenses in the given
             * status. */
            sequelize.literal(
              '(SELECT COUNT("id") FROM "Expenses" WHERE "Expenses"."CollectiveId" =' +
                ` "Collective"."id" AND "status" = ${status})`,
              args.expenseStatus,
            ),
            '>',
            0,
          );
        }
        const result = await models.Collective.findAndCountAll(query);
        const { count, rows } = result;
        return {
          total: count,
          collectives: rows,
          limit: args.limit,
          offset: args.offset,
        };
      },
    },
    followers: {
      type: new GraphQLList(CollectiveInterfaceType),
      args: {
        limit: { type: GraphQLInt },
        offset: { type: GraphQLInt },
      },
      resolve(collective, args) {
        return models.Member.findAll({
          where: { CollectiveId: collective.id, role: roles.FOLLOWER },
          include: [{ model: models.Collective, as: 'memberCollective' }],
          limit: args.limit,
          offset: args.offset,
        }).then(memberships => memberships.memberCollective);
      },
    },
    notifications: {
      type: new GraphQLList(NotificationType),
      args: {
        limit: { type: GraphQLInt },
        offset: { type: GraphQLInt },
        channel: { type: GraphQLString },
        type: { type: GraphQLString },
        active: { type: GraphQLBoolean },
      },
      resolve(collective, args, req) {
        // There's no reason for other people than admins to know about this.
        // Also the webhooks URL are supposed to be private (can contain tokens).
        if (!req.remoteUser || !req.remoteUser.isAdmin(collective.id)) {
          return [];
        }

        const where = { CollectiveId: collective.id };

        if (args.channel) {
          where.channel = args.channel;
        }
        if (args.type) {
          where.type = args.type;
        }
        if (args.active) {
          where.active = args.active;
        }

        return models.Notification.findAll({
          where: where,
          limit: args.limit,
          offset: args.offset,
          order: [['createdAt', 'ASC']],
        });
      },
    },
    maxQuantity: {
      type: GraphQLInt,
      resolve(collective) {
        return collective.maxQuantity;
      },
    },
    tiers: {
      type: new GraphQLList(TierType),
      args: {
        id: { type: GraphQLInt },
        slug: { type: GraphQLString },
        slugs: { type: new GraphQLList(GraphQLString) },
      },
      resolve(collective, args) {
        const where = {};

        if (args.id) {
          where.id = args.id;
        } else if (args.slug) {
          where.slug = args.slug;
        } else if (args.slugs && args.slugs.length > 0) {
          where.slug = { [Op.in]: args.slugs };
        }

        return collective.getTiers({
          where,
          order: [['amount', 'ASC']],
        });
      },
    },
    orders: {
      type: new GraphQLList(OrderType),
      args: {
        status: { type: OrderStatusType },
      },
      resolve(collective, args = {}, req) {
        const where = {};

        if (args.status === 'PENDING') {
          return req.loaders.Order.findPendingOrdersForCollective.load(collective.id);
        } else if (args.status) {
          where.status = args.status;
        } else {
          where.processedAt = { [Op.ne]: null };
        }

        return collective.getIncomingOrders({
          where,
          order: [['createdAt', 'DESC']],
        });
      },
    },
    ordersFromCollective: {
      type: new GraphQLList(OrderType),
      args: {
        subscriptionsOnly: { type: GraphQLBoolean },
      },
      resolve(collective, args) {
        const query = {
          where: {}, // TODO: might need a filter of 'processedAt'
          order: [['createdAt', 'DESC']],
        };

        if (args.subscriptionsOnly) {
          query.include = [
            {
              model: models.Subscription,
              required: true,
            },
          ];
        }
        return collective.getOutgoingOrders(query);
      },
    },
    transactions: {
      type: new GraphQLList(TransactionInterfaceType),
      args: {
        type: {
          type: GraphQLString,
          description: 'type of transaction (DEBIT/CREDIT)',
        },
        limit: { type: GraphQLInt },
        offset: { type: GraphQLInt },
        includeExpenseTransactions: {
          type: GraphQLBoolean,
          default: true,
          description: 'If false, only the transactions not linked to an expense (orders/refunds) will be returned',
        },
      },
      resolve(collective, args) {
        return collective.getTransactions({ ...args, order: [['id', 'DESC']] });
      },
    },
    expenses: {
      type: new GraphQLList(ExpenseType),
      args: {
        type: { type: GraphQLString },
        limit: { type: GraphQLInt },
        offset: { type: GraphQLInt },
        includeHostedCollectives: { type: GraphQLBoolean },
        status: { type: GraphQLString },
      },
      resolve(collective, args) {
        const query = { where: {} };
        if (args.status) {
          query.where.status = args.status;
        }
        if (args.limit) {
          query.limit = args.limit;
        }
        if (args.offset) {
          query.offset = args.offset;
        }
        query.order = [['createdAt', 'DESC']];
        const getCollectiveIds = () => {
          // if is host, we get all the expenses across all the hosted collectives
          if (args.includeHostedCollectives) {
            return models.Member.findAll({
              where: {
                MemberCollectiveId: collective.id,
                role: 'HOST',
              },
            }).map(members => members.CollectiveId);
          } else {
            return Promise.resolve([collective.id]);
          }
        };
        return getCollectiveIds().then(collectiveIds => {
          query.where.CollectiveId = { [Op.in]: collectiveIds };
          return models.Expense.findAll(query);
        });
      },
    },
    role: {
      type: GraphQLString,
      resolve(collective, args, req) {
        return collective.role || collective.getRoleForMemberCollective(req.remoteUser.CollectiveId);
      },
    },
    twitterHandle: {
      type: GraphQLString,
      resolve(collective) {
        return collective.twitterHandle;
      },
    },
    githubHandle: {
      type: GraphQLString,
      resolve: collective => collective.githubHandle,
    },
    website: {
      type: GraphQLString,
      resolve(collective) {
        return collective.website;
      },
    },
    updates: {
      type: new GraphQLList(UpdateType),
      args: {
        limit: { type: GraphQLInt },
        offset: { type: GraphQLInt },
        onlyPublishedUpdates: { type: GraphQLBoolean },
      },
      resolve(collective, args) {
        const query = { where: { CollectiveId: collective.id }, order: [['createdAt', 'DESC']] };
        if (args.limit) {
          query.limit = args.limit;
        }
        if (args.offset) {
          query.offset = args.offset;
        }
        if (args.onlyPublishedUpdates) {
          query.where.publishedAt = { [Op.ne]: null };
        }
        return models.Update.findAll(query);
      },
    },
    events: {
      type: new GraphQLList(EventCollectiveType),
      args: {
        limit: { type: GraphQLInt },
        offset: { type: GraphQLInt },
        includePastEvents: {
          type: GraphQLBoolean,
          defaultValue: false,
          description: 'Include past events',
        },
        includeInactive: {
          type: GraphQLBoolean,
          defaultValue: false,
          description: 'Include inactive events',
        },
      },
      resolve(collective, args) {
        const query = {
          where: { type: 'EVENT', ParentCollectiveId: collective.id },
          order: [
            ['startsAt', 'DESC'],
            ['endsAt', 'DESC'],
          ],
        };

        if (args.limit) {
          query.limit = args.limit;
        }
        if (args.offset) {
          query.offset = args.offset;
        }
        if (!args.includeInactive) {
          query.where.isActive = true;
        }
        if (!args.includePastEvents) {
          // Use midnight so we only mark events as passed the day after
          const today = new Date().setHours(0, 0, 0, 0);
          query.where = {
            [Op.and]: [
              // Include all previous conditions
              query.where,
              // An event is not passed if end date is in the future OR if end date
              // is not set but start date is in the past OR if there's no start date
              // nor end date
              {
                [Op.or]: [
                  { startsAt: null, endsAt: null },
                  { endsAt: { [Op.gte]: Date.now() } },
                  { endsAt: null, startsAt: { [Op.gte]: today } },
                ],
              },
            ],
          };
        }

        return models.Collective.findAll(query);
      },
    },
    childCollectives: {
      type: new GraphQLList(CollectiveType),
      description: "Get all child collectives (with type=COLLECTIVE, doesn't return events)",
      deprecationReason: '2020/01/08 - Connected-collectives are now handled through members',
      resolve(collective, _, req) {
        return req.loaders.Collective.childCollectives.load(collective.id);
      },
    },
    paymentMethods: {
      type: new GraphQLList(PaymentMethodType),
      args: {
        service: { type: GraphQLString },
        limit: { type: GraphQLInt },
        hasBalanceAboveZero: { type: GraphQLBoolean },
        isConfirmed: { type: GraphQLBoolean, defaultValue: true },
        types: { type: new GraphQLList(GraphQLString) },
        orderBy: {
          type: PaymentMethodOrderFieldType,
          defaultValue: 'type',
        },
        includeOrganizationCollectivePaymentMethod: {
          type: GraphQLBoolean,
          defaultValue: false,
          description: 'Defines if the organization "collective" payment method should be returned',
          deprecationReason: '2019-12-20: Replaced by includeHostCollectivePaymentMethod',
        },
        includeHostCollectivePaymentMethod: {
          type: GraphQLBoolean,
          defaultValue: false,
          description: 'Defines if the host "collective" payment method should be returned',
        },
      },
      async resolve(collective, args, req) {
        if (!req.remoteUser || !req.remoteUser.isAdmin(collective.id)) {
          return [];
        }
        let paymentMethods = await req.loaders.PaymentMethod.findByCollectiveId.load(collective.id);
        // Filter Payment Methods used by Hosts for "Add Funds"
        if (
          !args.includeOrganizationCollectivePaymentMethod &&
          !args.includeHostCollectivePaymentMethod &&
          (collective.type === 'ORGANIZATION' || collective.type === 'USER')
        ) {
          paymentMethods = paymentMethods.filter(pm => !(pm.service === 'opencollective' && pm.type === 'collective'));
        }
        // Filter only "saved" stripe Payment Methods
        // In the future we should only return the "saved" whatever the service
        paymentMethods = paymentMethods.filter(pm => pm.service !== 'stripe' || pm.saved);

        paymentMethods = paymentMethods.filter(pm => !(pm.data && pm.data.hidden));

        if (args.service) {
          paymentMethods = paymentMethods.filter(pm => pm.service === args.service);
        }
        if (args.types) {
          paymentMethods = paymentMethods.filter(pm => args.types.includes(pm.type));
        }
        if (args.isConfirmed !== undefined) {
          paymentMethods = paymentMethods.filter(pm => pm.isConfirmed() === args.isConfirmed);
        }
        if (args.hasBalanceAboveZero) {
          const filteredArray = [];
          for (const paymentMethod of paymentMethods) {
            const balance = await paymentMethod.getBalanceForUser(req.remoteUser);
            if (balance.amount > 0) {
              filteredArray.push(paymentMethod);
            }
            if (args.limit && filteredArray.length >= args.limit) {
              break;
            }
          }
          paymentMethods = filteredArray;
        }
        if (args.limit) {
          paymentMethods = paymentMethods.slice(0, args.limit);
        }
        if (args.orderBy) {
          paymentMethods = sortBy(paymentMethods, args.orderBy);
        }

        return paymentMethods;
      },
    },
    payoutMethods: {
      type: new GraphQLList(PayoutMethodType),
      description: 'The list of payout methods that this collective can use to get paid',
      async resolve(collective, _, req) {
        if (!req.remoteUser || !req.remoteUser.isAdmin(collective.id)) {
          return null;
        } else {
          return req.loaders.PayoutMethod.byCollectiveId.load(collective.id);
        }
      },
    },
    virtualCardsBatches: {
      type: new GraphQLList(PaymentMethodBatchInfo),
      description:
        'List all the gift cards batches emitted by this collective. May include `null` for unbatched gift cards.',
      resolve: async (collective, _args, req) => {
        // Must be admin of the collective
        if (!req.remoteUser || !req.remoteUser.isAdmin(collective.id)) {
          return [];
        }

        return queries.getVirtualCardBatchesForCollective(collective.id);
      },
    },
    createdVirtualCards: {
      type: PaginatedPaymentMethodsType,
      description: 'Get the virtual cards created by this collective. RemoteUser must be a collective admin.',
      args: {
        limit: { type: GraphQLInt },
        offset: { type: GraphQLInt },
        batch: { type: GraphQLString },
        isConfirmed: {
          type: GraphQLBoolean,
          description: 'Wether the virtual card has been claimed or not',
        },
      },
      resolve: async (collective, args, req) => {
        // Must be admin of the collective
        if (!req.remoteUser || !req.remoteUser.isAdmin(collective.id)) {
          return [];
        }

        const offset = args.offset || 0;
        const limit = args.limit || 15;
        const query = {
          where: { type: 'virtualcard', service: 'opencollective' },
          limit: args.limit,
          offset: args.offset,
          order: [
            ['createdAt', 'DESC'],
            ['id', 'DESC'],
          ],
          include: [
            {
              model: models.PaymentMethod,
              as: 'sourcePaymentMethod',
              where: { CollectiveId: collective.id },
              required: true,
              attributes: [],
            },
          ],
        };

        if (args.isConfirmed !== undefined) {
          query.where.confirmedAt = { [args.isConfirmed ? Op.ne : Op.eq]: null };
        }

        if (args.batch !== undefined) {
          query.where.batch = args.batch;
        }

        const result = await models.PaymentMethod.findAndCountAll(query);

        return {
          paymentMethods: result.rows,
          total: result.count,
          limit,
          offset,
        };
      },
    },
    connectedAccounts: {
      type: new GraphQLList(ConnectedAccountType),
      resolve(collective, args, req) {
        return req.loaders.Collective.connectedAccounts.load(collective.id);
      },
    },
    features: {
      type: new GraphQLNonNull(CollectiveFeatures),
      description: 'Describes the features enabled and available for this collective',
      resolve: collective => collective,
    },
    plan: {
      type: PlanType,
      resolve(collective) {
        return collective.getPlan();
      },
    },
    stats: {
      type: CollectiveStatsType,
      resolve(collective) {
        return collective;
      },
    },
  };
};

const CollectiveFeatureStatus = new GraphQLEnumType({
  name: 'CollectiveFeatureStatus',
  values: {
    [FEATURE_STATUS.ACTIVE]: {
      description: 'The feature is enabled and is actively used',
    },
    [FEATURE_STATUS.AVAILABLE]: {
      description: 'The feature is enabled, but there is no data for it',
    },
    [FEATURE_STATUS.DISABLED]: {
      description: 'The feature is disabled, but can be enabled by an admin',
    },
    [FEATURE_STATUS.UNSUPPORTED]: {
      description: 'The feature is disabled and cannot be activated for this account',
    },
  },
});

export const CollectiveFeatures = new GraphQLObjectType({
  name: 'CollectiveFeatures',
  description: 'Describes the features enabled and available for this collective',
  fields: {
    [FEATURE.CONVERSATIONS]: {
      type: CollectiveFeatureStatus,
      resolve: getFeatureStatusResolver(FEATURE.CONVERSATIONS),
    },
    [FEATURE.COLLECTIVE_GOALS]: {
      type: CollectiveFeatureStatus,
      resolve: getFeatureStatusResolver(FEATURE.COLLECTIVE_GOALS),
    },
    [FEATURE.RECEIVE_EXPENSES]: {
      type: CollectiveFeatureStatus,
      resolve: getFeatureStatusResolver(FEATURE.RECEIVE_EXPENSES),
    },
    [FEATURE.UPDATES]: {
      type: CollectiveFeatureStatus,
      resolve: getFeatureStatusResolver(FEATURE.UPDATES),
    },
    [FEATURE.TRANSFERWISE]: {
      type: CollectiveFeatureStatus,
      resolve: getFeatureStatusResolver(FEATURE.TRANSFERWISE),
    },
    [FEATURE.PAYPAL_PAYOUTS]: {
      type: CollectiveFeatureStatus,
      resolve: getFeatureStatusResolver(FEATURE.PAYPAL_PAYOUTS),
    },
  },
});

export const CollectiveType = new GraphQLObjectType({
  name: 'Collective',
  description: 'This represents a Collective',
  interfaces: [CollectiveInterfaceType],
  fields: CollectiveFields,
});

export const UserCollectiveType = new GraphQLObjectType({
  name: 'User',
  description: 'This represents a User Collective',
  interfaces: [CollectiveInterfaceType],
  fields: () => {
    return {
      ...CollectiveFields(),
      firstName: {
        type: GraphQLString,
        deprecationReason: '2020-03-27: These field are now deprecated in favor of collective.name',
        resolve(userCollective, args, req) {
          return (
            userCollective && req.loaders.getUserDetailsByCollectiveId.load(userCollective.id).then(u => u.firstName)
          );
        },
      },
      lastName: {
        type: GraphQLString,
        deprecationReason: '2020-03-27: These field are now deprecated in favor of collective.name',
        resolve(userCollective, args, req) {
          return (
            userCollective && req.loaders.getUserDetailsByCollectiveId.load(userCollective.id).then(u => u.lastName)
          );
        },
      },
      email: {
        type: GraphQLString,
        resolve(userCollective, args, req) {
          if (!req.remoteUser) {
            return null;
          } else if (userCollective.isIncognito) {
            if (getContextPermission(req, PERMISSION_TYPE.SEE_INCOGNITO_ACCOUNT_DETAILS, userCollective.id)) {
              return req.loaders.User.byId.load(userCollective.CreatedByUserId).then(u => u.email);
            }
          } else {
            return (
              userCollective &&
              req.loaders.getUserDetailsByCollectiveId.load(userCollective.id).then(user => user.email)
            );
          }
        },
      },
      applications: {
        type: new GraphQLList(ApplicationType),
        resolve(userCollective, _, req) {
          if (req.remoteUser && req.remoteUser.isAdmin(userCollective.id)) {
            return models.Application.findAll({
              where: { CollectiveId: userCollective.id },
            });
          }
        },
      },
    };
  },
});

export const OrganizationCollectiveType = new GraphQLObjectType({
  name: 'Organization',
  description: 'This represents a Organization Collective',
  interfaces: [CollectiveInterfaceType],
  fields: () => {
    return {
      ...CollectiveFields(),
      email: {
        type: GraphQLString,
        async resolve(orgCollective, args, req) {
          if (!req.remoteUser) {
            return null;
          }
          return (
            orgCollective && req.loaders.getOrgDetailsByCollectiveId.load(orgCollective.id).then(user => user.email)
          );
        },
      },
    };
  },
});

export const EventCollectiveType = new GraphQLObjectType({
  name: 'Event',
  description: 'This represents an Event Collective',
  interfaces: [CollectiveInterfaceType],
  fields: CollectiveFields,
});

export const CollectiveSearchResultsType = new GraphQLObjectType({
  name: 'CollectiveSearchResults',
  description: 'The results from searching for collectives with pagination info',
  fields: () => ({
    id: {
      type: GraphQLString,
      description: 'A unique identifier for this search (for caching)',
    },
    collectives: {
      type: new GraphQLList(CollectiveType),
    },
    limit: {
      type: GraphQLInt,
    },
    offset: {
      type: GraphQLInt,
    },
    total: {
      type: GraphQLInt,
    },
  }),
});
