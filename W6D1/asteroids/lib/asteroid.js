const MovingObject = require('./moving_object.js');
const Util = require('./utils.js');

const COLOR = 'green';
const RADIUS = 17;
const SPEED = 10;

function Asteroid(options) {
  // to access the code that sets properties such as this.pos and this.vel
  MovingObject.call(this, options);

  this.color = options['color'] || COLOR;
  this.radius = options['radius'] || RADIUS;
  this.vel = options['vel'] || Util.randomVec(SPEED);
  this.pos = options['pos'];
  this.game = options.game;
}

Util.inherits(Asteroid, MovingObject);

module.exports = Asteroid;
