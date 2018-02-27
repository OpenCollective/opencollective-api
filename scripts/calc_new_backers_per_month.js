/*
 * This script runs through a few checks and lets us know if something is off
 */

import Promise from 'bluebird';
import fs from 'fs';
import moment from 'moment';
import json2csv from 'json2csv';
import models, { sequelize } from '../server/models';


const done = (err) => {
  if (err) console.log(err);
  console.log('\ndone!\n');``
  process.exit();
}

const results = {};
const arrayLength = 30;
//const csvFields = ['id', 'slug', 'newBackerCount', 'oldBackerCount'];
const outputFilename = 'new_backer_count_output.csv';

const getMonthYearKeyFromDate = (date) => {
  return `${date.getUTCFullYear()}-${`0${date.getUTCMonth() +1}`.slice(-2)}`
}

const calculateNewBackersPerMonth = () => {

  const seenFromCollectiveIdList = {};

  return models.Order.findAll({
    where: {
      /*PaymentMethodId: {
        $not: null
      }*/
      CollectiveId: {
        [sequelize.Op.notIn]: [ 1 ]
      }
    },
    include: [
      { model: models.Collective, as: 'fromCollective', paranoid: false }, 
      { model: models.Collective, as: 'collective', paranoid: false }
    ],
    order: ['id']
  })
  .tap(orders => console.log('Orders found: ', orders.length))
  .each(order => {
    const dateKey = getMonthYearKeyFromDate(order.createdAt);
    if (order.FromCollectiveId in seenFromCollectiveIdList) {
      // ignore it
    } else {
      // means this is a new backer
      seenFromCollectiveIdList[order.FromCollectiveId] = true;
      if (dateKey in results) {
        results[dateKey] += 1;
      } else {
        results[dateKey] = 1;
      }
    }
  })
  .then(() => {
    let csvFields = ['month', 'newBackers'];
    console.log(results);
    const data = Object.keys(results).map(result => ({'month': result, 'newBackers': results[result]}));
    console.log(data);
    json2csv({ data , fields: csvFields }, (err, csv) => {
      console.log('Writing the output to', outputFilename);
      if (err) console.log(err);
      fs.writeFileSync(outputFilename, csv)
    });
  })

}

const run = () => {
  console.log('\nStarting calc_new_backers_per_month...')
  
  return calculateNewBackersPerMonth()
  .then(() => done())
  .catch(done)
}

run();
