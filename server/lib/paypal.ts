/* eslint-disable camelcase */
import paypal from '@paypal/payouts-sdk';
import config from 'config';
import express from 'express';

import { PayoutBatchDetails, PayoutRequestBody, PayoutRequestResult } from '../types/paypal';

import { floatAmountToCents } from './math';

const parseError = e => {
  try {
    return JSON.parse(e.message).message;
  } catch (_) {
    return e.message;
  }
};

type ConnectedAccount = {
  token: string;
  clientId: string;
  settings?: {
    webhookId: string;
  };
};

const getPayPalClient = ({ token, clientId }: ConnectedAccount): ReturnType<typeof paypal.core.PayPalHttpClient> => {
  const environment =
    config.env === 'production'
      ? new paypal.core.LiveEnvironment(clientId, token)
      : new paypal.core.SandboxEnvironment(clientId, token);

  return new paypal.core.PayPalHttpClient(environment);
};

const executeRequest = async (
  connectedAccount: ConnectedAccount,
  request: PayoutRequestBody | Record<string, unknown>,
): Promise<any> => {
  try {
    const client = getPayPalClient(connectedAccount);
    const response = await client.execute(request);
    return response.result;
  } catch (e) {
    throw new Error(parseError(e));
  }
};

export const executePayouts = async (
  connectedAccount: ConnectedAccount,
  requestBody: PayoutRequestBody,
): Promise<PayoutRequestResult> => {
  const request = new paypal.payouts.PayoutsPostRequest();
  request.requestBody(requestBody);
  return executeRequest(connectedAccount, request);
};

export const getBatchInfo = async (
  connectedAccount: ConnectedAccount,
  batchId: string,
): Promise<PayoutBatchDetails> => {
  const request = new paypal.payouts.PayoutsGetRequest(batchId);
  request.page(1);
  request.pageSize(100);
  request.totalRequired(true);
  return executeRequest(connectedAccount, request);
};

export const validateConnectedAccount = async ({ token, clientId }: ConnectedAccount): Promise<void> => {
  const client = getPayPalClient({ token, clientId });
  await client.fetchAccessToken();
};

export const validateWebhookEvent = async (
  { token, clientId, settings }: ConnectedAccount,
  req: express.Request,
): Promise<void> => {
  const client = getPayPalClient({ token, clientId });
  const request = {
    path: '/v1/notifications/verify-webhook-signature',
    verb: 'POST',
    body: {
      auth_algo: req.get('PAYPAL-AUTH-ALGO'),
      cert_url: req.get('PAYPAL-CERT-URL'),
      transmission_id: req.get('PAYPAL-TRANSMISSION-ID'),
      transmission_sig: req.get('PAYPAL-TRANSMISSION-SIG'),
      transmission_time: req.get('PAYPAL-TRANSMISSION-TIME'),
      webhook_id: settings.webhookId,
      webhook_event: req.body,
    },
    headers: {
      'Content-Type': 'application/json',
    },
  };
  try {
    const response = await client.execute(request);
    if (response?.result?.verification_status !== 'SUCCESS') {
      throw new Error('Invalid webhook request');
    }
  } catch (e) {
    throw new Error(parseError(e));
  }
};

/** Converts a PayPal amount like '12.50' to its value in cents (1250) */
export const paypalAmountToCents = (amountStr: string): number => {
  return floatAmountToCents(parseFloat(amountStr));
};

export { paypal };
