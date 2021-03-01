import { GraphQLNonNull } from 'graphql';

import { types as collectiveTypes } from '../../../constants/collectives';
import { NotFound, Unauthorized } from '../../errors';
import { AccountReferenceInput, fetchAccountWithReference } from '../input/AccountReferenceInput';
import { Collective } from '../object/Collective';

const { COLLECTIVE } = collectiveTypes;

const collectiveMutations = {
  applyToHost: {
    type: new GraphQLNonNull(Collective),
    description: 'Apply to an host with a collective',
    args: {
      collective: {
        type: new GraphQLNonNull(AccountReferenceInput),
        description: 'Account applying to the host.',
      },
      host: {
        type: new GraphQLNonNull(AccountReferenceInput),
        description: 'Host to apply to.',
      },
    },
    async resolve(_, args, req): Promise<object> {
      if (!req.remoteUser) {
        throw new Unauthorized('You need to be logged in');
      }

      const collective = await fetchAccountWithReference(args.collective);
      if (!collective) {
        throw new NotFound('Collective not found');
      }
      if (collective.type !== COLLECTIVE) {
        throw new Error('Account not a Collective');
      }
      if (!req.remoteUser.isAdmin(collective.id)) {
        throw new Unauthorized('You need to be an Admin of the Collective');
      }

      const host = await fetchAccountWithReference(args.host);
      if (!host) {
        throw new NotFound('Host not found');
      }

      // No need to check the balance, this is being handled in changeHost, along with most other checks

      return collective.changeHost(host.id, req.remoteUser);
    },
  },
};

export default collectiveMutations;
