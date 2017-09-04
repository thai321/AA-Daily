/*
We've learned a couple of ways to implement class inheritance in Javascript. Let's first look at using a Surrogate.

There are a number of steps:

_ Define a Surrogate class
_ Set the prototype of the Surrogate (Surrogate.prototype = SuperClass.prototype)
_ Set Subclass.prototype = new Surrogate()
_ Set Subclass.prototype.constructor = Subclass


Write a Function.prototype.inherits method that will do this for you.
Do not use Object.create right now; you should deeply understand what
the new keyword does and how the __proto__ chain is constructed.
This will help you in Asteroids today:

function MovingObject () {}

function Ship () {}
Ship.inherits(MovingObject);

function Asteroid () {}
Asteroid.inherits(MovingObject);


How would you test Function.prototype.inherits? A few specs to consider:

_ You should be able to define methods/attributes on MovingObject that ship
and asteroid instances can use.
_ Defining a method on Asteroid's prototype should not mean that a ship can call it.
_ Adding to Ship or Asteroid's prototypes should not change MovingObject's prototype.
_ The Ship and Asteroid prototypes should not be instances of MovingObject.

After you have written Function.prototype.inherits using the surrogate trick,
refactor your solution using Object.create. Make sure to test
that your updated solution works

And finally, take a look at our answers.
Make sure you thoroughly understand what both solutions do.
You'll be writing an inherits method again for Asteroids.

*/

console.log('--------inherits-------');

Function.prototype.inherits = function inherits(parrent) {
  // // Define a Surrogate class
  // function Surrogate() {}
  //
  // // Set the prototype of the Surrogate
  // Surrogate.prototype = parrent.prototype;

  this.prototype = Object.create(parrent.prototype);

  // this.prototype = new Surrogate();
  this.prototype.constructor = this;
};

function MovingObject(type) {
  this.type = type;
}

MovingObject.prototype.moving = function moving() {
  console.log(this.type + ' is moving....');
};

function Ship(type, name) {
  MovingObject.call(this, type);
  this.name = name;
}
Ship.inherits(MovingObject);

function Asteroird(type, name) {
  MovingObject.call(this, type);
  this.name = name;
}
Asteroird.inherits(MovingObject);

const ship1 = new Ship('Ship', 'ShipAA');
const asteroid1 = new Asteroird('Asteroid', 'asteroidAA');

ship1.moving();
asteroid1.moving();
