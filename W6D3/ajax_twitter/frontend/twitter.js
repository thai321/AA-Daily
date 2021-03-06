const FollowToggle = require('./follow_toggle.js');
const UsersSearch = require('./users_search.js');
const TweetCompose = require('./tweet_compose.js');

$(() => {
  //callback
  // buttions
  $buttons = $('button');
  $buttons.each((idx, button) => {
    const follow = new FollowToggle($(button));
  });

  // users search

  $userNavs = $('nav.users-search');
  $userNavs.each((idx, userNav) => {
    const user = new UsersSearch($(userNav));
  });

  $tweetForm = $('form.tweet-compose');
  let ulId = $tweetForm.data('tweets-ul');
  $tweetUl = $(`ul${ulId}`);
  $tweetForm.each((idx, tweetForm) => {
    const form = new TweetCompose($(tweetForm), $($tweetUl[0]));
  });
});
