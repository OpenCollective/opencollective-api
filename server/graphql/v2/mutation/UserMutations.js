import { GraphQLNonNull } from 'graphql';
import { GraphQLDateTime } from 'graphql-iso-date';

import { Unauthorized, ValidationFailed } from '../../errors';
import { fetchAccountWithReference } from '../input/AccountReferenceInput';
import { Individual } from '../object/Individual';

const userMutations = {
  setChangelogViewDate: {
    type: new GraphQLNonNull(Individual),
    description: 'Update the time which the user viewed the changelog updates',
    args: {
      changelogViewDate: {
        type: new GraphQLNonNull(GraphQLDateTime),
      },
    },
    resolve: async (_, { changelogViewDate }, { remoteUser }) => {
      if (!remoteUser) {
        throw new Unauthorized();
      } else if (!changelogViewDate) {
        throw new ValidationFailed('The change log view date must be set');
      }
      const date = new Date(changelogViewDate);
      const user = await remoteUser.update({ changelogViewDate: date });
      return await fetchAccountWithReference({ id: user.CollectiveId });
    },
  },
};

export default userMutations;
