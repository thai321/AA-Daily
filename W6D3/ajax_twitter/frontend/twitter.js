const FollowToggle = require('./follow_toggle.js');
const UsersSearch = require('./users_search.js');

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
});
