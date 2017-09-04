const Util = {
  inherits(childClass, parentClass) {
    function Surrogate() {}
    Surrogate.prototype = parentClass.prototype;
    childClass.prototype = new Surrogate();
    childClass.prototype.constructor = childClass;
  },

  // Return a randomly oriented vector with the given length.
  randomVec(length) {
    const deg = 2 * Math.PI * Math.random();
    return Util.scale([Math.sin(deg), Math.cos(deg)], length);
  },

  scale(vec, m) {
    return [vec[0] * m, vec[1] * m];
  },

  distance(pos1, pos2) {
    const x_1 = pos1[0];
    const y_1 = pos1[1];

    const x_2 = pos2[0];
    const y_2 = pos2[1];

    return Math.sqrt(Math.pow(x_1 - x_2, 2) + Math.pow(y_1 - y_2, 2));
  },

  norm(pos) {
    return this.distance([0, 0], pos);
  }
};

module.exports = Util;
