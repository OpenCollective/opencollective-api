import { expect } from 'chai';
import { describe, it } from 'mocha';
import schema from '../server/graphql/schema';
import { graphql } from 'graphql';

import * as utils from './utils';


describe('Query Tests', () => {
  /* SETUP
    group1: 2 events
      event1: 2 tiers
        tier1: 2 responses
        tier2: 1 response
      event2: 1 tier
        tier3: no response
    group2: 1 event
      event3: no tiers // event3 not declared above due to linting
    group3: no events
  */

  before(() => utils.loadDB("wwcode_test"));


  describe('Root query tests', () => {

    describe('returns event(s)', () => {

      it('when given an event slug and collectiveSlug (case insensitive)', async () => {
        const query = `
          query Collective {
            Collective(collectiveSlug: "wwcodeaustin") {
              id,
              slug,
              transactions {
                id,
                type,
                user {
                  id,
                  firstName,
                  email
                },
                host {
                  id,
                  firstName
                  email
                },
                ... on Expense {
                  attachment
                }
                ... on Donation {
                  paymentMethod {
                    id,
                    service
                  },
                  subscription {
                    id,
                    interval
                  }
                }
              }
            }
          }
        `;
        const context = { remoteUser: null };
        const result = await graphql(schema, query, null, context);
        expect(result.errors).to.not.exist;
        const transactions = result.data.Collective.transactions;
        expect(transactions.length).to.equal(76);
        const expense = transactions.find(t => t.type === 'EXPENSE');
        const donation = transactions.find(t => t.type === 'DONATION');
        expect(expense).to.have.property('attachment');
        expect(donation).to.have.property('paymentMethod');
        expect(donation.user.id).to.equal(646); // Lindsey user
        expect(donation.host.id).to.equal(3); // wwcode host
        expect(donation.user.email).to.equal(null); // can't see email if not logged in
        expect(donation.host.email).to.equal(null);
      });

    });
  });
});
