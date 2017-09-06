const View = require('./ttt-view.js');
const Game = require('./game.js');

$(() => {
  // Your code here
  let game = new Game();
  let $ttt = $('.ttt');

  let view = new View(game, $ttt);
});
