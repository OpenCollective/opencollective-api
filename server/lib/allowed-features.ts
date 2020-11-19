import { get } from 'lodash';

import { types } from '../constants/collectives';
import FEATURE from '../constants/feature';

// Please refer to and update https://docs.google.com/spreadsheets/d/15ppKaZJCXBjvY7-AjjCj3w5D-4ebLQdEowynJksgDXE/edit#gid=0
const FeatureAllowedForTypes = {
  // Collective page features
  [FEATURE.RECEIVE_FINANCIAL_CONTRIBUTIONS]: [
    types.ORGANIZATION,
    types.COLLECTIVE,
    types.EVENT,
    types.FUND,
    types.PROJECT,
  ],
  [FEATURE.RECURRING_CONTRIBUTIONS]: [types.USER, types.ORGANIZATION, types.COLLECTIVE, types.FUND],
  [FEATURE.EVENTS]: [types.ORGANIZATION, types.COLLECTIVE],
  [FEATURE.PROJECTS]: [types.FUND],
  [FEATURE.USE_EXPENSES]: [types.ORGANIZATION, types.COLLECTIVE, types.EVENT, types.FUND, types.PROJECT],
  [FEATURE.RECEIVE_EXPENSES]: [types.ORGANIZATION],
  [FEATURE.COLLECTIVE_GOALS]: [types.COLLECTIVE, types.ORGANIZATION],
  [FEATURE.TOP_FINANCIAL_CONTRIBUTORS]: [types.COLLECTIVE, types.ORGANIZATION, types.FUND],
  [FEATURE.CONVERSATIONS]: [types.COLLECTIVE, types.ORGANIZATION],
  [FEATURE.UPDATES]: [types.COLLECTIVE, types.ORGANIZATION],
  [FEATURE.TEAM]: [types.ORGANIZATION, types.COLLECTIVE, types.EVENT, types.FUND, types.PROJECT],
  // Other
  [FEATURE.CONTACT_FORM]: [types.COLLECTIVE, types.EVENT],
  [FEATURE.TRANSFERWISE]: [types.ORGANIZATION],
  [FEATURE.PAYPAL_PAYOUTS]: [types.ORGANIZATION],
  [FEATURE.PAYPAL_DONATIONS]: [types.ORGANIZATION],
};

/**
 * A map of paths to retrieve the value of a feature flag from a collective
 */
export const OPT_OUT_FEATURE_FLAGS = {
  [FEATURE.CONTACT_FORM]: 'settings.features.contactForm',
  [FEATURE.CONVERSATIONS]: 'settings.features.conversations',
  [FEATURE.UPDATES]: 'settings.features.updates',
};

export const OPT_IN_FEATURE_FLAGS = {
  [FEATURE.CROSS_CURRENCY_MANUAL_TRANSACTIONS]: 'settings.features.crossCurrencyManualTransactions',
  [FEATURE.COLLECTIVE_GOALS]: 'settings.collectivePage.showGoals',
};

const FEATURES_ONLY_FOR_HOST_ORGS = [
  FEATURE.RECEIVE_FINANCIAL_CONTRIBUTIONS,
  FEATURE.USE_EXPENSES,
  FEATURE.RECEIVE_EXPENSES,
  FEATURE.TOP_FINANCIAL_CONTRIBUTORS,
  FEATURE.COLLECTIVE_GOALS,
  FEATURE.TRANSFERWISE,
  FEATURE.PAYPAL_PAYOUTS,
  FEATURE.PAYPAL_DONATIONS,
];

/**
 * Returns true if feature is allowed for this collective type, false otherwise.
 */
export const isFeatureAllowedForCollectiveType = (collectiveType: types, feature: FEATURE, isHost?: false): boolean => {
  const allowedTypes = FeatureAllowedForTypes[feature];
  const allowedForType = allowedTypes ? allowedTypes.includes(collectiveType) : true;

  if (!allowedForType) {
    return false;
  }

  // Check if allowed for host orgs but not normal orgs
  if (collectiveType === types.ORGANIZATION && FEATURES_ONLY_FOR_HOST_ORGS.includes(feature) && !isHost) {
    return false;
  }

  return true;
};

export const hasOptedOutOfFeature = (collective, feature): boolean => {
  const optOutFlag = OPT_OUT_FEATURE_FLAGS[feature];
  return optOutFlag ? get(collective, optOutFlag) === false : false;
};

export const hasOptedInForFeature = (collective, feature): boolean => {
  const optOutFlag = OPT_IN_FEATURE_FLAGS[feature];
  return get(collective, optOutFlag) === true;
};

/**
 * If a given feature is allowed for the collective type, check if it is activated for collective.
 */
export const hasFeature = (collective, feature: FEATURE): boolean => {
  if (!collective) {
    return false;
  }

  if (!isFeatureAllowedForCollectiveType(collective.type, feature, collective.isHostAccount)) {
    return false;
  }

  // Check opt-out flags
  if (feature in OPT_OUT_FEATURE_FLAGS) {
    return !hasOptedOutOfFeature(collective, feature);
  }

  // Check opt-in flags
  if (feature in OPT_IN_FEATURE_FLAGS) {
    return hasOptedInForFeature(collective, feature);
  }

  return true;
};

export { FEATURE };
