/**
 * Defines what users are allowed to do on the platform.
 */

import FEATURE from '../constants/feature';
import models from '../models';

/**
 * Returns true if the given user can use the passed feature. Will always return false
 * if user is not set.
 */
export const canUseFeature = (user: typeof models.User, feature: FEATURE): boolean => {
  // Must be provided
  if (!user) {
    return false;
  }

  // Check if user is limited, globally or for this specific feature
  const userFeaturesFlags = user.data && user.data.features;
  if (userFeaturesFlags) {
    if (userFeaturesFlags.ALL === false || userFeaturesFlags[feature] === false) {
      return false;
    }
  }

  return true;
};
