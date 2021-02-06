import { GraphQLBoolean, GraphQLFloat, GraphQLNonNull, GraphQLString } from 'graphql';
import GraphQLJSON from 'graphql-type-json';
import { cloneDeep, pick, set } from 'lodash';

import plans from '../../../constants/plans';
import cache from '../../../lib/cache';
import { crypto } from '../../../lib/encryption';
import { verifyTwoFactorAuthenticatorCode } from '../../../lib/two-factor-authentication';
import models, { sequelize } from '../../../models';
import { Forbidden, NotFound, Unauthorized, ValidationFailed } from '../../errors';
import { AccountTypeToModelMapping } from '../enum/AccountType';
import { AccountReferenceInput, fetchAccountWithReference } from '../input/AccountReferenceInput';
import { AccountUpdateInput } from '../input/AccountUpdateInput';
import { Account } from '../interface/Account';
import { Host } from '../object/Host';
import { Individual } from '../object/Individual';
import AccountSettingsKey from '../scalar/AccountSettingsKey';

const accountMutations = {
  editAccount: {
    type: new GraphQLNonNull(Account),
    description: 'Edit the info for the given account',
    args: {
      account: {
        type: new GraphQLNonNull(AccountUpdateInput),
        description: 'Account where the settings will be updated',
      },
    },
    async resolve(_, args, req): Promise<object> {
      if (!req.remoteUser) {
        throw new Unauthorized();
      }

      return sequelize.transaction(async transaction => {
        const account = await fetchAccountWithReference(args.account, {
          dbTransaction: transaction,
          lock: true,
          throwIfMissing: true,
        });

        if (!req.remoteUser.isAdminOfCollective(account)) {
          throw new Forbidden();
        }

        return account.update(
          pick(args.account, [
            'name',
            'company',
            'description',
            'longDescription',
            'twitterHandle',
            'githubHandle',
            'website',
            'tags',
          ]),
          { transaction },
        );
      });
    },
  },
  editAccountSetting: {
    type: new GraphQLNonNull(Account),
    description: 'Edit the settings for the given account',
    args: {
      account: {
        type: new GraphQLNonNull(AccountReferenceInput),
        description: 'Account where the settings will be updated',
      },
      key: {
        type: new GraphQLNonNull(AccountSettingsKey),
        description: 'The key that you want to edit in settings',
      },
      value: {
        type: new GraphQLNonNull(GraphQLJSON),
        description: 'The value to set for this key',
      },
    },
    async resolve(_, args, req): Promise<object> {
      if (!req.remoteUser) {
        throw new Unauthorized();
      }

      return sequelize.transaction(async transaction => {
        const account = await fetchAccountWithReference(args.account, {
          dbTransaction: transaction,
          lock: true,
          throwIfMissing: true,
        });

        if (!req.remoteUser.isAdminOfCollective(account)) {
          throw new Forbidden();
        }

        if (
          args.key === 'collectivePage' &&
          ![AccountTypeToModelMapping.FUND, AccountTypeToModelMapping.PROJECT].includes(account.type)
        ) {
          const budgetSection = args.value.sections?.find(s => s.section === 'budget');
          if (budgetSection && !budgetSection.isEnabled) {
            throw new Forbidden();
          }
        }

        const settings = account.settings ? cloneDeep(account.settings) : {};
        set(settings, args.key, args.value);
        return account.update({ settings }, { transaction });
      });
    },
  },
  editAccountFeeStructure: {
    type: new GraphQLNonNull(Account),
    description: 'An endpoint for hosts to edit the fees structure of their hosted accounts',
    args: {
      account: {
        type: new GraphQLNonNull(AccountReferenceInput),
        description: 'Account where the settings will be updated',
      },
      hostFeePercent: {
        type: new GraphQLNonNull(GraphQLFloat),
        description: 'The host fee percent to apply to this account',
      },
      isCustomFee: {
        type: new GraphQLNonNull(GraphQLBoolean),
        description: 'If using a custom fee, set this to true',
      },
    },
    async resolve(_, args, req): Promise<object> {
      return sequelize.transaction(async dbTransaction => {
        const account = await fetchAccountWithReference(args.account, {
          throwIfMissing: true,
          dbTransaction,
          lock: true,
        });

        if (!account.HostCollectiveId) {
          throw new ValidationFailed('Fees structure can only be edited for accounts that you are hosting');
        } else if (!req.remoteUser?.isAdmin(account.HostCollectiveId)) {
          throw new Forbidden(
            'You need to be logged in as an host admin to change the fees structure of the hosted accounts',
          );
        } else if (!account.approvedAt) {
          throw new ValidationFailed('The collective needs to be approved before you can change the fees structure');
        }

        return account.update(
          {
            hostFeePercent: args.hostFeePercent,
            data: { ...account.data, useCustomHostFee: args.isCustomFee },
          },
          { transaction: dbTransaction },
        );
      });
    },
  },
  addTwoFactorAuthTokenToIndividual: {
    type: new GraphQLNonNull(Individual),
    description: 'Add 2FA to the Account if it does not have it',
    args: {
      account: {
        type: new GraphQLNonNull(AccountReferenceInput),
        description: 'Account that will have 2FA added to it',
      },
      token: {
        type: new GraphQLNonNull(GraphQLString),
        description: 'The generated secret to save to the Account',
      },
    },
    async resolve(_, args, req): Promise<object> {
      if (!req.remoteUser) {
        throw new Unauthorized();
      }

      const account = await fetchAccountWithReference(args.account);

      if (!req.remoteUser.isAdminOfCollective(account)) {
        throw new Forbidden();
      }

      const user = await models.User.findOne({ where: { CollectiveId: account.id } });

      if (!user) {
        throw new NotFound('Account not found.');
      }

      if (user.twoFactorAuthToken !== null) {
        throw new Unauthorized('This account already has 2FA enabled.');
      }

      /*
      check that base32 secret is only capital letters, numbers (2-7), 103 chars long;
      Our secret is 64 ascii characters which is encoded into 104 base32 characters
      (base32 should be divisible by 8). But the last character is an = to pad, and
      speakeasy library cuts out any = padding
      **/
      const verifyToken = args.token.match(/([A-Z2-7]){103}/);
      if (!verifyToken) {
        throw new ValidationFailed('Invalid 2FA token');
      }

      const encryptedText = crypto.encrypt(args.token);

      await user.update({ twoFactorAuthToken: encryptedText });

      return account;
    },
  },
  removeTwoFactorAuthTokenFromIndividual: {
    type: new GraphQLNonNull(Individual),
    description: 'Remove 2FA from the Account if it has been enabled',
    args: {
      account: {
        type: new GraphQLNonNull(AccountReferenceInput),
        description: 'Account that will have 2FA removed from it',
      },
      code: {
        type: new GraphQLNonNull(GraphQLString),
        description: 'The 6-digit 2FA code',
      },
    },
    async resolve(_, args, req): Promise<object> {
      if (!req.remoteUser) {
        throw new Unauthorized();
      }

      const account = await fetchAccountWithReference(args.account);

      if (!req.remoteUser.isAdminOfCollective(account)) {
        throw new Forbidden();
      }

      const user = await models.User.findOne({ where: { CollectiveId: account.id } });

      if (!user) {
        throw new NotFound('Account not found.');
      }

      if (!user.twoFactorAuthToken) {
        throw new Unauthorized('This account already has 2FA disabled.');
      }

      const verified = verifyTwoFactorAuthenticatorCode(user.twoFactorAuthToken, args.code);

      if (!verified) {
        throw new Unauthorized('Two-factor authentication code failed. Please try again');
      }

      await user.update({ twoFactorAuthToken: null });

      return account;
    },
  },
  editHostPlan: {
    type: new GraphQLNonNull(Host),
    description: 'Update the plan',
    args: {
      account: {
        type: new GraphQLNonNull(AccountReferenceInput),
        description: 'Account that will have 2FA added to it',
      },
      plan: {
        type: new GraphQLNonNull(GraphQLString),
        description: 'The name of the plan to subscribe to.',
      },
    },
    async resolve(_, args, req): Promise<object> {
      if (!req.remoteUser) {
        throw new Unauthorized();
      }

      const account = await fetchAccountWithReference(args.account);
      if (!req.remoteUser.isAdminOfCollective(account)) {
        throw new Forbidden();
      }
      if (!account.isHostAccount) {
        throw new Error(`Only Fiscal Hosts can set their plan.`);
      }

      const plan = args.plan;
      if (!plans[plan]) {
        throw new Error(`Unknown plan: ${plan}`);
      }

      await account.update({ plan });

      if (plan === 'start-plan-2021') {
        // This should cascade to all Collectives
        await account.updateHostFee(0, req.remoteUser);
      }

      if (plan === 'start-plan-2021' || plan === 'grow-plan-2021') {
        // This should cascade to all Collectives
        await account.updatePlatformFee(0, req.remoteUser);
      }

      await cache.del(`plan_${account.id}`);

      return account;
    },
  },
};

export default accountMutations;
