const config = require('config');
const Promise = require('bluebird');
const Twitter = require('twitter');
const activityType = require('../constants/activities');

function tweetActivity(activity, models) {
  if (activity.type === activityType.GROUP_TRANSACTION_CREATED
    && activity.data.transaction.amount > 0
    // users without twitterHandle are ignored
    && activity.data.user.twitterHandle) {
      const status = `@${activity.data.user.twitterHandle} thanks for backing us!`;
      return tweetStatus(models.ConnectedAccount, activity.GroupId, status);
  } else {
    return Promise.resolve();
  }
}

function tweetStatus(ConnectedAccount, GroupId, status) {
  return ConnectedAccount.findOne({
    where: {
      GroupId,
      provider: 'twitter'
    }
  })
  .tap(connectedAccount => {
    // groups without twitter credentials are ignored
    if (connectedAccount) {
      const client = new Twitter({
        consumer_key: config.twitter.consumerKey,
        consumer_secret: config.twitter.consumerSecret,
        access_token_key: connectedAccount.clientId,
        access_token_secret: connectedAccount.secret
      });

      const tweet = Promise.promisify(client.post, { context: client });
      console.log(`Tweeting for group ID ${GroupId}: ${status}`);
      return tweet("statuses/update", { status });
    }
  });
}

module.exports = {
  tweetActivity,
  tweetStatus
};
