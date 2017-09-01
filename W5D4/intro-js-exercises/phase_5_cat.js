function Cat(name, owner) {
  this.name = name;
  this.owner = owner;
}

Cat.prototype.cuteStatement = function() {
  return `${this.owner} loves ${this.name}`;
};

const cat1 = new Cat("Breakfast", "Thai");
const cat2 = new Cat("Taco", "Trevor");

cat1.cuteStatement();
cat2.cuteStatement = function() {
  return `Everyone loved ${this.name}!`;
};

console.log(cat1.cuteStatement());
console.log(cat2.cuteStatement());

Cat.prototype.meow = function() {
  console.log("Meow");
};

cat1.meow();

cat2.meow = function() {
  console.log("Woof");
};

cat1.meow();
cat2.meow();
