const FollowToggle = require('./follow_toggle.js');

$(() => {
  //callback
  $buttons = $('button');
  console.log($buttons);
  $buttons.each((idx, button) => {
    const follow = new FollowToggle($(button));
    console.log(follow);
  });
});
