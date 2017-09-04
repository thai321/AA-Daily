const Asteroid = require('./asteroid.js');

Game.DIM_X = 800;
Game.DIM_Y = 800;
Game.NUM_ASTEROIDS = 4;

function Game() {
  this.asteroids = [];
  this.addAsteroids();
}

Game.prototype.addAsteroids = function addAsteroids() {
  // Call randomPosition
  for (let i = 0; i < Game.NUM_ASTEROIDS; i++) {
    const asteroid = new Asteroid({ pos: this.randomPosition() });
    this.asteroids.push(asteroid);
  }
};

Game.prototype.randomPosition = function randomPosition() {
  const x = Math.floor(Math.random() * Game.DIM_X);
  const y = Math.floor(Math.random() * Game.DIM_Y);
  return [x, y];
};

Game.prototype.draw = function draw(ctx) {
  // void ctx.clearRect(x, y, width, height);
  ctx.clearRect(0, 0, Game.DIM_X, Game.DIM_Y);
  ctx.fillStyle = 'black';
  ctx.fillRect(0, 0, Game.DIM_X, Game.DIM_Y);

  // call draw method on each of the asteroid
  this.asteroids.forEach(asteroid => {
    asteroid.draw(ctx);
  });
};

Game.prototype.moveObjects = function moveObject(d_pos) {
  // call move on each of the asteroids

  this.asteroids.forEach(asteroid => {
    asteroid.move(d_pos);
  });
};

module.exports = Game;
