import { GraphQLInt, GraphQLString, GraphQLInputObjectType } from 'graphql';

import models from '../../../models';
import { idDecode } from '../identifiers';
import { NotFound } from '../../errors';

export const AccountReferenceInput = new GraphQLInputObjectType({
  name: 'AccountReferenceInput',
  fields: () => ({
    id: {
      type: GraphQLString,
      description: 'The public id identifying the account (ie: dgm9bnk8-0437xqry-ejpvzeol-jdayw5re)',
    },
    legacyId: {
      type: GraphQLInt,
      description: 'The internal id of the account (ie: 580)',
      deprecationReason: '2020-01-01: should only be used during the transition to GraphQL API v2.',
    },
    slug: {
      type: GraphQLString,
      description: 'The slug identifying the account (ie: babel for https://opencollective.com/babel)',
    },
  }),
});

export const fetchAccountWithReference = async (input, { loaders, throwIfMissing } = {}) => {
  let collective;
  if (input.id) {
    const id = idDecode(input.id, 'account');
    collective = await loaders.Collective.byId.load(id);
  } else if (input.legacyId) {
    collective = await loaders.Collective.byId.load(input.legacyId);
  } else if (input.slug) {
    collective = await models.Collective.findOne({ where: { slug: input.slug.toLowerCase() } });
  } else {
    throw new Error('Please provide an id or a slug');
  }
  if (!collective && throwIfMissing) {
    throw new NotFound({ message: 'Account Not Found' });
  }
  return collective;
};
