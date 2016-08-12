module.exports = function(app) {

  /**
   * Controllers.
   */
  const cs = {};
  const controllers = [
    'activities',
    'donations',
    'expenses',
    'paymentmethods',
    'groups',
    'images',
    'middlewares',
    'paypal',
    'homepage',
    'profile',
    'notifications',
    'stripe',
    'subscriptions',
    'users',
    'webhooks',
    'test',
    'connectedAccounts'
  ];

  const services = [
    'mailgun',
    'meetup'
  ]

  /**
   * Exports.
   */
  controllers.forEach((controller) => {
    cs[controller] = require(`${__dirname}/${controller}`)(app);
  });

  cs.services = {};
  services.forEach((controller) => {
    cs.services[controller] = require(`${__dirname}/services/${controller}`)(app);
  });

  return cs;

};
