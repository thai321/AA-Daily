const Game = require('./game.js');

function GameView(game, ctx) {
  this.game = game;
  this.ctx = ctx;
}

MOVES = [[0, 1], [0, -1], [1, 0], [-1, 0]];

GameView.prototype.start = function start() {
  // Call setInterval to call Game.prototype.moveObjects
  // and Game.prototype.draw once every 20ms or so

  setInterval(() => {
    const i = Math.floor(Math.random() * MOVES.length);
    this.game.moveObjects(MOVES[i]);
    this.game.draw(this.ctx);
  }, 200);
};

module.exports = GameView;
