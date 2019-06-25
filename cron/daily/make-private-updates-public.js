#!/usr/bin/env node
import '../../server/env';

import models, { Op } from '../../server/models';
import logger from '../../server/lib/logger';

// get the ISOtime for the day @ midnight to compare
// against the update.makePublic on time field

const today = new Date(new Date().setUTCHours(0, 0, 0, 0)).toISOString();
logger.info(`Updates for ${today}`);

let updatesMadePublic = 0;

// get all the private updates with the makePublicOn <= today
// and make them public
models.Update.findAll({
  where: {
    isPrivate: true,
    makePublicOn: { [Op.lte]: today },
  },
})
  .map(update => processUpdate(update))
  .then(() => {
    logger.info(`Number of private updates made public: ${updatesMadePublic}`);
    process.exit(0);
  });

async function processUpdate(update) {
  await update.makePublic();
  updatesMadePublic++;
}
