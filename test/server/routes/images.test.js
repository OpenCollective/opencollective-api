import fs from 'fs';
import path from 'path';

import { expect } from 'chai';
import config from 'config';
import fetch from 'node-fetch';
import request from 'supertest';

import app from '../../../server/index';
import models from '../../../server/models';
import * as utils from '../../utils';

const application = utils.data('application');
const userData = utils.data('user1');

describe('server/routes/images', () => {
  let user, expressApp;

  before(async () => {
    expressApp = await app();
  });

  before(function () {
    if (!config.aws.s3.key) {
      this.skip();
    }
  });

  beforeEach(() => utils.resetTestDB());

  /**
   * Create user
   */

  beforeEach(async () => {
    user = await models.User.create(userData);
  });

  it('should upload an image to S3', done => {
    const originalImage = fs.readFileSync(path.join(__dirname, '../../mocks/images/camera.png'), {
      encoding: 'utf8',
    });
    request(expressApp)
      .post(`/images/?api_key=${application.api_key}`)
      .attach('file', 'test/mocks/images/camera.png')
      .set('Authorization', `Bearer ${user.jwt()}`)
      .expect(200)
      .then(res => {
        expect(res.body.url).to.contain('.png');
        return fetch(res.body.url).then(res => res.text());
      })
      .then(image => {
        expect(image).to.equal(originalImage);
        done();
      })
      .catch(done);
  });

  it('should throw an error if no file field is sent', done => {
    request(expressApp)
      .post(`/images/?api_key=${application.api_key}`)
      .set('Authorization', `Bearer ${user.jwt()}`)
      .expect(400)
      .end(done);
  });

  it('should upload if the user is not logged in', done => {
    request(expressApp)
      .post(`/images/?api_key=${application.api_key}`)
      .attach('file', 'test/mocks/images/camera.png')
      .expect(200)
      .end(done);
  });
});
