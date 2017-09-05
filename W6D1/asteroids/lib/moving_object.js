const Util = require('./utils.js');

function MovingObject(options) {
  this.pos = options.pos;
  this.vel = options.vel;
  this.radius = options.radius;
  this.color = options.color;
  this.game = options.game;
}

MovingObject.prototype.draw = function draw(ctx) {
  const x = this.pos[0];
  const y = this.pos[1];

  ctx.fillStyle = 'green';

  ctx.beginPath();
  // void ctx.arc(x, y, radius, startAngle, endAngle, anticlockwise);
  ctx.arc(x, y, this.radius, 0, 2 * Math.PI);

  ctx.fill();
};

MovingObject.prototype.move = function move(vel) {
  const dx = vel[0];
  const dy = vel[1];

  const x = this.pos[0];
  const y = this.pos[1];

  const newPos = this.game.wrap([x + dx, y + dy]);
  this.pos[0] = newPos[0];
  this.pos[1] = newPos[1];
};

MovingObject.prototype.isCollidedWith = function isCollidedWith(other) {
  const currentDistance = Util.distance(this.pos, other.pos);
  const sumRadii = this.radius + other.radius;
  console.log('hello');
  return currentDistance < sumRadii;
};

module.exports = MovingObject;
