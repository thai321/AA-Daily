Array.prototype.myEach = function(callback) {
  for (let i = 0; i < this.length; i++) {
    callback(this[i]);
  }
};

Array.prototype.myMap = function(callback) {
  const result = [];
  this.myEach(el => {
    result.push(callback(el));
  });

  return result;
};

Array.prototype.myReduce = function(callback, startingVal) {
  let sum = startingVal || 0;
  this.myEach(el => {
    sum += callback(el);
  });

  return sum;
};
