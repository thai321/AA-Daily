const Game = require('./game.js');

function GameView(game, ctx) {
  this.game = game;
  this.ctx = ctx;
}

GameView.prototype.start = function start() {
  // Call setInterval to call Game.prototype.moveObjects
  // and Game.prototype.draw once every 20ms or so

  setInterval(() => {
    // this.game.moveObjects(DIRS[i]);
    this.game.step();
    this.game.draw(this.ctx);
  }, 300);
};

module.exports = GameView;
