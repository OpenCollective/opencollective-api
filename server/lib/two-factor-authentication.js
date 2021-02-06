import { get, isNil } from 'lodash';
import speakeasy from 'speakeasy';

import cache from './cache';
import { crypto } from './encryption';

export const ROLLING_LIMIT_CACHE_VALIDITY = 3600; // 1h in secs for cache to expire

/**
 * Verifies a TOTP against a user's 2FA token saved in the DB
 * encryptedTwoFactorAuthToken = token saved for a User in the DB
 * twoFactorAuthenticatorCode = 6-digit TOTP
 */
export function verifyTwoFactorAuthenticatorCode(encryptedTwoFactorAuthToken, twoFactorAuthenticatorCode) {
  const decryptedTwoFactorAuthToken = crypto.decrypt(encryptedTwoFactorAuthToken);
  const verified = speakeasy.totp.verify({
    secret: decryptedTwoFactorAuthToken,
    encoding: 'base32',
    token: twoFactorAuthenticatorCode,
    window: 2,
  });
  return verified;
}

const getTwoFactorAuthenticationLimitKey = userId => {
  return `${userId}_2fa_payment_limit`;
};

export async function handleTwoFactorAuthenticationPayoutLimit(user, twoFactorAuthenticatorCode, expense) {
  if (user.twoFactorAuthToken !== null) {
    const host = await expense.collective.getHostCollective();
    const hostPayoutTwoFactorAuthenticationRollingLimit = get(
      host,
      'settings.payoutsTwoFactorAuth.rollingLimit',
      1000000,
    );
    // 1. we check the 'cache' if the key exists: cacheKey=${user.id}_2fa_payment_limit
    const twoFactorAuthenticationLimitKey = getTwoFactorAuthenticationLimitKey(user.id);
    const twoFactorAuthenticationLimitAmountForUser = await cache.get(twoFactorAuthenticationLimitKey);

    if (twoFactorAuthenticatorCode) {
      const verified = verifyTwoFactorAuthenticatorCode(user.twoFactorAuthToken, twoFactorAuthenticatorCode);
      if (!verified) {
        throw new Error('Two-factor authentication failed: invalid code. Please try again.');
      }
      // With 2FA code
      // 2. if limit key exists, reset the limit; if limit key doesn't exist, initialise the limit
      cache.set(twoFactorAuthenticationLimitKey, 0, ROLLING_LIMIT_CACHE_VALIDITY);
      return;
    } else {
      // Without 2FA code
      // 2. if the limit key does exist, check the value
      // 3. if the payment fits the limit, process the payment, decrease the limit
      // 4. if it doesn't fit the limit, prompt 2FA again
      if (isNil(twoFactorAuthenticationLimitAmountForUser)) {
        // 5. if the limit key doesn't exist, ask for 2FA
        throw new Error('Two-factor authentication enabled: please enter your code.');
      } else {
        const runningTotal = twoFactorAuthenticationLimitAmountForUser + expense.amount;
        const expenseExceedsRollingLimit = runningTotal > hostPayoutTwoFactorAuthenticationRollingLimit;
        if (expenseExceedsRollingLimit) {
          throw new Error('Two-factor authentication payout limit exceeded: please re-enter your code.');
        } else {
          cache.set(twoFactorAuthenticationLimitKey, runningTotal, ROLLING_LIMIT_CACHE_VALIDITY);
          return;
        }
      }
    }
  } else {
    throw new Error('Host has two-factor authentication enabled for large payouts.');
  }
}

export async function resetRollingPayoutLimitOnFailure(user, expense) {
  const twoFactorAuthenticationLimitKey = getTwoFactorAuthenticationLimitKey(user.id);
  const twoFactorAuthenticationLimitAmountForUser = await cache.get(twoFactorAuthenticationLimitKey);

  if (!isNil(twoFactorAuthenticationLimitAmountForUser) && twoFactorAuthenticationLimitAmountForUser !== 0) {
    cache.set(
      twoFactorAuthenticationLimitKey,
      twoFactorAuthenticationLimitAmountForUser - expense.amount,
      ROLLING_LIMIT_CACHE_VALIDITY,
    );
  }

  return;
}
