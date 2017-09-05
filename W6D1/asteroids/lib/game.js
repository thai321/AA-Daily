const Asteroid = require('./asteroid.js');
const Util = require('./utils.js');

Game.DIM_X = 800;
Game.DIM_Y = 800;
Game.NUM_ASTEROIDS = 10;
// Game.DIRS = [[0, 1], [0, -1], [1, 0], [-1, 0]];

function Game() {
  this.asteroids = [];
  this.addAsteroids();
}

Game.prototype.addAsteroids = function addAsteroids() {
  // Call randomPosition
  for (let i = 0; i < Game.NUM_ASTEROIDS; i++) {
    const asteroid = new Asteroid({
      pos: this.randomPosition(),
      game: this
    });
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

Game.prototype.moveObjects = function moveObject() {
  // call move on each of the asteroids

  this.asteroids.forEach(asteroid => {
    asteroid.move(asteroid.vel);
  });
};

Game.prototype.wrap = function wrap(pos) {
  const x = Util.changePos(pos[0], Game.DIM_X);
  const y = Util.changePos(pos[1], Game.DIM_Y);

  return [x, y];
};

Game.prototype.checkCollisions = function checkCollisions() {
  for (let i = 0; i < this.asteroids.length; i++) {
    for (let j = 0; j < this.asteroids.length; j++) {
      if (i !== j) {
        const asteroid1 = this.asteroids[i];
        const asteroid2 = this.asteroids[j];
        if (asteroid1.isCollidedWith(asteroid2)) {
          alert('COLLISION');
          const i = this.asteroids.indexOf(asteroid1);
          const j = this.asteroids.indexOf(asteroid2);
          this.remove(i, j);
          return;
        }
      }
    }
  }
};

Game.prototype.remove = function remove(i, j) {
  this.asteroids.splice(i, 1);
  this.asteroids.splice(j, 1);
};

Game.prototype.step = function step() {
  this.moveObjects();
  this.checkCollisions();
};

module.exports = Game;
