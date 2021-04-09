import { GraphQLInt, GraphQLNonNull, GraphQLObjectType, GraphQLString } from 'graphql';

export const UpdateAudienceStats = new GraphQLObjectType({
  name: 'UpdateAudienceStats',
  description: 'Stats about the potential audience of an update',
  fields: () => {
    return {
      id: {
        type: new GraphQLNonNull(GraphQLString),
      },
      individuals: {
        type: new GraphQLNonNull(GraphQLInt),
      },
      organizations: {
        type: new GraphQLNonNull(GraphQLInt),
      },
      collectives: {
        type: new GraphQLNonNull(GraphQLInt),
      },
      hosted: {
        type: new GraphQLNonNull(GraphQLInt),
      },
      total: {
        type: new GraphQLNonNull(GraphQLInt),
        description: 'The total number of emails to send',
      },
    };
  },
});
