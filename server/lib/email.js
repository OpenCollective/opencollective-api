const config = require('config');
const _ = require('lodash');
const Promise = require('bluebird');
const juice = require('juice');
const nodemailer = require('nodemailer');

const debug = require('debug')('email');
const templates = require('./loadEmailTemplates')();
const activities = require('../constants/activities');
const utils = require('./utils');
const crypto = require('crypto');

const render = (name, data, config) => {
    data.config = config;
    data.logoNotSvg = data.group && data.group.logo && !data.group.logo.endsWith('.svg');
    return templates[name](data);
};

const generateUnsubscribeToken = (email, groupSlug, type) => {
  const uid = `${email}.${groupSlug}.${type}.${config.keys.opencollective.resetPasswordSecret}`;
  return crypto.createHash('md5').update(uid).digest("hex");
}

/*
 * Gets the body from a string (usually a template)
 */
const getBody = str => str.split('\n').slice(2).join('\n');

/*
 * Appends appropriate prefix and cleans up subject
 */
const getSubject = str => {
    var subj = '';
    if (process.env.NODE_ENV === 'staging') {
      subj += '[STAGING] ';
    } else if (process.env.NODE_ENV !== 'production'){
      subj += '[TESTING] ';
    }
    subj += str.split('\n')[0].replace(/^Subject: ?/i, '');
    return subj;
};

/*
 * sends an email message to a recipient with given subject and body
 */
const sendMessage = (recipient, subject, html, options) => {
  options = options || {};
  debug("email: ", recipient, subject, html, options);

  // if not in production, only send out emails to bcc'd opencollective address
  if (process.env.NODE_ENV !== 'production' && !utils.isEmailInternal(recipient)) {
    recipient = '';
  }

  if (config.mailgun.user) {
    const mailgun = nodemailer.createTransport({
      service: 'Mailgun',
      auth: {
        user: config.mailgun.user,
        pass: config.mailgun.password
      }
    });

    return new Promise((resolve, reject) => {
      mailgun.sendMail({
        from: options.from || config.email.from,
        to: recipient,
        bcc: `ops@opencollective.com,${options.bcc}`,
        subject,
        html
      }, (err, info) => {
        if (err) {
          return reject(err);
        } else {
          return resolve(info);
        }
      })
    });
  } else {
    console.warn("Warning: No mail sent - Mailgun is not configured");
    return Promise.resolve();
  }
};

/*
 * Given a template, recipient and data, generates email.
 */

const generateEmailFromTemplate = (template, recipient, data, options) => {

  options = options || {};

  if (template === 'thankyou') {
    if (data.group.name.match(/WWCode/i))
      template += '.wwcode';
    if (data.group.name.match(/ispcwa/i))
      template += '.ispcwa';
    if (_.contains(['lesbarbares', 'nuitdebout', 'laprimaire'], data.group.slug)) {
      template += '.fr';

      if (data.group.slug === 'laprimaire')
        template = 'thankyou.laprimaire';

      // xdamman: hack
      switch (data.interval) {
        case 'month':
          data.interval = 'mois';
          break;
        case 'year':
          data.interval = 'an';
          break;
      }
    }
  }

  if (template === 'group.transaction.created') {
    template = (data.transaction.amount > 0) ? 'group.donation.created' : 'group.expense.created';
    if (data.user && data.user.twitterHandle) {
      const groupMention = (data.group.twitterHandle) ? `@${data.group.twitterHandle}` : data.group.name;
      const text = `Hi @${data.user.twitterHandle} thanks for your donation to ${groupMention} https://opencollective.com/${data.group.slug} 🎉😊`;
      data.tweet = {
        text,
        encoded: encodeURIComponent(text)
      };
    }
  }

  data.unsubscribeUrl = `${config.host.website}/api/services/email/unsubscribe/${encodeURIComponent(options.bcc || recipient)}/${options.slug || data.slug}/${options.type || template}/${generateUnsubscribeToken(options.bcc || recipient, options.slug || data.slug, options.type)}`;

  if (!templates[template]) {
    return Promise.reject(new Error("Invalid email template"));
  }
  return Promise.resolve(juice(render(template, data, config)));
};

/*
 * Given a template, recipient and data, generates email and sends it.
 * Deprecated. Should use sendMessageFromActivity() for sending new emails.
 */
const generateEmailFromTemplateAndSend = (template, recipient, data, options) => {
  return generateEmailFromTemplate(template, recipient, data, options)
    .then(templateString => emailLib.sendMessage(recipient, getSubject(templateString), getBody(templateString), options));
};

/*
 * Given an activity, it sends out an email to the right people and right template
 */
const sendMessageFromActivity = (activity, notification) => {
  if (activity.type === activities.GROUP_TRANSACTION_CREATED) {
    return generateEmailFromTemplateAndSend('group.transaction.created', notification.User.email, activity.data);
  } else {
    return Promise.resolve();
  }
}

const emailLib = {
  getBody,
  getSubject,
  sendMessage,
  generateEmailFromTemplate,
  send: generateEmailFromTemplateAndSend,
  sendMessageFromActivity
};

module.exports = emailLib;