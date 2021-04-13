export enum PAYMENT_METHOD_SERVICE {
  PAYPAL = 'paypal',
  BRAINTREE = 'braintree',
  STRIPE = 'stripe',
  OPENCOLLECTIVE = 'opencollective',
  PREPAID = 'prepaid',
}
export const PAYMENT_METHOD_SERVICES = Object.values(PAYMENT_METHOD_SERVICE);

export enum PAYMENT_METHOD_TYPE {
  CREDITCARD = 'creditcard',
  PREPAID = 'prepaid',
  PAYMENT = 'payment',
  SUBSCRIPTION = 'subscription',
  COLLECTIVE = 'collective',
  HOST = 'host',
  ADAPTIVE = 'adaptive',
  PAYPAL = 'paypal', // Braintree service supports multiple payment methods including PayPal
  GIFT_CARD = 'giftcard',
  MANUAL = 'manual',
}
export const PAYMENT_METHOD_TYPES = Object.values(PAYMENT_METHOD_TYPE);
