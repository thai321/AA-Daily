function Cat(name) {
  this.name = name;
}

Cat.prototype.meow = function() {
  console.log('meow');
};

module.exports = Cat;
