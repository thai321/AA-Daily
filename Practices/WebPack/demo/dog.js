function Dog(name) {
  this.name = name;
}

Dog.prototype.woof = function() {
  console.log('woof');
};

module.exports = Dog;
