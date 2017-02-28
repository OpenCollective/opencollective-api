import config from 'config';
import moment from 'moment';
import models from '../models';
import errors from '../lib/errors';
import paypalAdaptive from '../gateways/paypalAdaptive';

const {
  Activity,
  PaymentMethod
} = models;

/**
 * Get preapproval details route
 */
export const getDetails = function(req, res, next) {
  const preapprovalKey = req.params.preapprovalkey;

  return getPreapprovalDetailsAndUpdatePaymentMethod(preapprovalKey, req.remoteUser.id)
    .then(response => res.json(response))
    .catch(next);
};

/**
 * Get a preapproval key for a user.
 */
export const getPreapprovalKey = function(req, res, next) {
  // TODO: The cancel URL doesn't work - no routes right now.
  const uri = `/users/${req.remoteUser.id}/paypal/preapproval/`;
  const baseUrl = config.host.website + uri;
  const cancelUrl = req.query.cancelUrl || (`${baseUrl}/cancel`);
  const returnUrl = req.query.returnUrl || (`${baseUrl}/success`);
  const endingDate = (req.query.endingDate && (new Date(req.query.endingDate)).toISOString()) || moment().add(1, 'years').toISOString();
  
  const maxTotalAmountOfAllPayments = req.query.maxTotalAmountOfAllPayments || 2000; // 2000 is the maximum: https://developer.paypal.com/docs/classic/api/adaptive-payments/Preapproval_API_Operation/

  const payload = {
    currencyCode: 'USD', // TODO: figure out if there is a reliable way to specify correct currency for a HOST.
    startingDate: new Date().toISOString(),
    endingDate,
    returnUrl,
    cancelUrl,
    displayMaxTotalAmount: true,
    feesPayer: 'SENDER',
    maxTotalAmountOfAllPayments,
    clientDetails: req.remoteUser.id
  };

  let response;

  return paypalAdaptive.preapproval(payload)
  .tap(r => response = r)
  .then(response => PaymentMethod.create({
    service: 'paypal',
    UserId: req.remoteUser.id,
    token: response.preapprovalKey
  }))
  .then(() => res.json(response))
  .catch(next);
};

/**
 * Confirm a preapproval.
 */
export const confirmPreapproval = function(req, res, next) {
  let paymentMethod;

  // fetch original payment method
  return PaymentMethod.findOne({
    where: {
      service: 'paypal',
      UserId: req.remoteUser.id,
      token: req.params.preapprovalkey
    }
  })
  .tap(pm => paymentMethod = pm)
  .then(pm => pm ? Promise.resolve() : Promise.reject(new errors.NotFound('This preapprovalKey does not exist.')))

  .then(() => getPreapprovalDetailsAndUpdatePaymentMethod(req.params.preapprovalkey, req.remoteUser.id, paymentMethod))

  .then(() => Activity.create({
    type: 'user.paymentMethod.created',
    UserId: req.remoteUser.id,
    data: {
      user: req.remoteUser.minimal,
      paymentMethod
    }
  }))
  
  // clean any old payment methods
  .then(() => PaymentMethod.findAll({
    where: {
      service: 'paypal',
      UserId: req.remoteUser.id,
      token: {$ne: req.params.preapprovalkey}
    }
  }))
  .then(oldPMs => oldPMs && oldPMs.map(pm => pm.destroy()))

  .then(() => res.send(paymentMethod.info))
  .catch(next)
};

/*
 * Takes a Payment Response
 */
const getPreapprovalDetailsAndUpdatePaymentMethod = function(preapprovalKey, userId, paymentMethod = null) {

  let preapprovalDetailsResponse;

  return paypalAdaptive.preapprovalDetails(preapprovalKey)
    .tap(response => preapprovalDetailsResponse = response)
    .then(response => response.approved === 'false' ? 
      Promise.reject(new errors.BadRequest('This preapprovalkey is not approved yet.')) : 
      Promise.resolve())
    .then(() => paymentMethod ? paymentMethod :  PaymentMethod.findOne({
        where: {
          service: 'paypal',
          UserId: userId,
          token: preapprovalKey
        }
      }))
    .then(paymentMethod => {
      const maxTotalAmountOfAllPayments = preapprovalDetailsResponse.maxTotalAmountOfAllPayments * 100;
      const amountUsed = preapprovalDetailsResponse.curPaymentsAmount * 100;
      const amountRemaining = maxTotalAmountOfAllPayments - preapprovalDetailsResponse.curPaymentsAmount;

      return paymentMethod.update({
        confirmedAt: new Date(),
        number: preapprovalDetailsResponse.senderEmail,
        data: {
          preapprovalDetailsResponse,
          maxTotalAmountOfAllPayments,
          amountUsed,
          amountRemaining
        }
      })
    })
    .then(() => preapprovalDetailsResponse);
}