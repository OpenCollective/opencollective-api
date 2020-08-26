import { GraphQLFloat, GraphQLInt, GraphQLObjectType } from 'graphql';

import { Currency } from '../enum/Currency';

export const Amount = new GraphQLObjectType({
  name: 'Amount',
  description: 'A financial amount.',
  fields: {
    value: {
      type: GraphQLFloat,
      resolve(amount) {
        if (amount.value === null) {
          return null;
        } else {
          return parseInt(amount.value, 10) / 100;
        }
      },
    },
    currency: {
      type: Currency,
      resolve(amount) {
        return amount.currency;
      },
    },
    valueInCents: {
      type: GraphQLInt,
      resolve(amount) {
        return parseInt(amount.value, 10);
      },
    },
  },
});
