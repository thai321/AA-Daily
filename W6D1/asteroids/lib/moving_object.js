function MovingObject(options) {
  this.pos = options.pos;
  this.vel = options.vel;
  this.radius = options.radius;
  this.color = options.color;
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
  const x = vel[0];
  const y = vel[1];

  this.pos[0] += x;
  this.pos[1] += y;
};

module.exports = MovingObject;
