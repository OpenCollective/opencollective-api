import { expect } from 'chai';

import models from '../../../server/models';
import { randEmail } from '../../stores';
import * as utils from '../../utils';

describe('server/models/Update', () => {
  const dateOffset = 24 * 60 * 60 * 1000;
  const today = new Date().setUTCHours(0, 0, 0, 0);
  const yesterday = new Date(today - 1).setUTCDate(0, 0, 0, 0);
  const tomorrow = new Date(today + dateOffset);

  let user, collective;
  before(() => utils.resetTestDB());
  before('create a user', () =>
    models.User.createUserWithCollective({
      name: 'Xavier',
      email: randEmail(),
    }).then(u => (user = u)),
  );
  before('create a collective', () => models.Collective.create({ name: 'Webpack' }).then(c => (collective = c)));

  before('create updates', async () => {
    await models.Update.createMany(
      [
        { id: 1, title: 'update 1 - yesterday', isPrivate: true, makePublicOn: yesterday },
        { id: 2, title: 'update 2 - today', isPrivate: true, makePublicOn: today },
        { id: 3, title: 'update 3 - tomorrow', isPrivate: true, makePublicOn: tomorrow },
        { id: 4, title: 'update 4', isPrivate: true, makePublicOn: null },
        { id: 5, title: 'unique-slug', isPrivate: false, makePublicOn: null },
      ],
      { CreatedByUserId: user.id, CollectiveId: collective.id },
    );
  });

  before('run makeUpdatesPublic', async () => {
    await models.Update.makeUpdatesPublic();
  });

  describe('private update must be public when', () => {
    it('update.makePublicOn < today', async () => {
      const update = await models.Update.findByPk(1);
      expect(update.dataValues.isPrivate).to.equal(false);
    });
    it('update.makePublicOn = today', async () => {
      const update = await models.Update.findByPk(2);
      expect(update.dataValues.isPrivate).to.equal(false);
    });
  });

  describe('private update must not be public when', () => {
    it('update.makePublicOn > today', async () => {
      const update = await models.Update.findByPk(3);
      expect(update.dataValues.isPrivate).to.equal(true);
    });

    it('update.makePublicOn is null', async () => {
      const update = await models.Update.findByPk(4);
      expect(update.dataValues.isPrivate).to.equal(true);
    });
  });

  describe('delete update', () => {
    it('frees up current slug when deleted', async () => {
      const uniqueSlug = 'unique-slug';
      const update = await models.Update.findOne({ where: { slug: uniqueSlug } });
      expect(update.slug).to.equal('unique-slug');
      await update.destroy();
      // free up slug after deletion
      expect(uniqueSlug).to.not.be.equal(update.slug);
      expect(/-\d+$/.test(update.slug)).to.be.true;
    });
  });
});
