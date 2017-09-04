# Asteroids

## Learning Goals

+ Be able to implement prototypal inheritance to give a class another class's
methods and attributes
+ Be able to include JavaScript in a web page
  + Know how Webpack works
  + Know how to test JavaScript code using `window.x = x`
+ Know how to render information from JavaScript objects on a page
  + Know how to draw on a web page using Canvas

**[Live Demo][live-demo]**

[live-demo]: http://appacademy.github.io/curriculum/asteroids/index.html

## Overview

We'll decompose the Asteroids game into the following
classes/sourcefiles:

* `Util` (`lib/utils.js`)
    * Utility code, especially vector math stuff.
* `MovingObject` (`lib/moving_object.js`)
    * Base class for anything that moves.
    * Most important methods are `MovingObject.prototype.move`, `MovingObject.prototype.draw(ctx)`,
      `MovingObject.prototype.isCollidedWith(otherMovingObject)`.
* `Asteroid` (`lib/asteroid.js`)
    * Spacerock. It inherits from `MovingObject`.
* `Bullet` (`lib/bullet.js`)
    * Kill spacerocks with this. Also a `MovingObject` subclass.
* `Ship` (`lib/ship.js`)
    * This is you! Another `MovingObject` subclass.
* `Game` (`lib/game.js`)
    * Holds collections of the asteroids, bullets, and your ship.
    * `Game.prototype.step` method calls `Game.prototype.move` on all the objects, and
      `Game.prototype.checkCollisions` checks for colliding objects.
    * `Game.prototype.draw(ctx)` draws the game.
    * Keeps track of dimensions of the space; wraps objects around when
      they drift off the screen.
* `GameView` (`lib/game_view.js`)
    * Stores a `Game` instance.
    * Stores a `canvas` context to draw the game into.
    * Installs key listeners to move the ship and fire bullets.
    * Installs a timer to call `Game.prototype.step`.

## Important Note Regarding ES6

** Do not use ES6 class syntax in this project.**  Understanding prototypal
inheritance is a main focus of today's project. Because ES6 class syntax
obscures how prototypal inheritance works, and has some incompatibilities with
the instructions below, avoid using it while working today. After the project is
over, review both the ES5 and ES6 solutions to see how they differ. Ask your TA
for a more nuanced explanation of this if you need more information.

## A Refresher on Vectors

You'll use a lot of **vectors** in this assignment.

2D vectors have an `x` and a `y` component. A position vector has an `x`
and `y` position, while a velocity vector has a speed in the `x` and the
`y` directions.

#### Distance

To find the "distance" between two points, the formula is:

    // this is math, not JavaScript
    Dist([x_1, y_1], [x_2, y_2]) = sqrt((x_1 - x_2) ** 2 + (y_1 - y_2) ** 2)

#### Norm

A vector has a **norm**, a.k.a. **magnitude** or **length**. The norm of
a velocity vector is a speed. If `obj.vel = [3, 4]` (3 horizontal pixels
and 4 vertical pixels per unit time) then the overall speed is 5 pixels
per unit time. You can easily calculate the norm of a vector using your
distance function:

    Norm([x_1, y_1]) = Dist([0, 0], [x_1, y_1])


## Phase 0: `index.html`

Write a mostly empty HTML file for your game to run in. Open your `index.html`
in  your browser and use the browser's JavaScript console to test your code  as
you go.

Don't forget to [webpack][browser-modules] your modules.

[browser-modules]: ../../readings/browser-modules.md

## Phase I: `MovingObject` and `Asteroid`

### `MovingObject`

Write a `MovingObject` class in `lib/moving_object.js`.

Store key instance variables:

* 2D `pos`ition. 2D `vel`ocity. `radius` (everything in the game is a circle).
* `color`

Rather than pass all these as separate arguments, write your `MovingObject`
constructor function so that you can pass in an options object:

```js
const mo = new MovingObject(
  { pos: [30, 30], vel: [10, 10], radius: 5, color: "#00FF00"}
);
```

Write a `MovingObect.prototype.draw(ctx)` method. Draw a circle of the appropriate `radius` centered
at `pos`. Fill it with the appropriate `color`. Refer to the Drunken Circles
demo if you need a refresher on Canvas.

Write a `MovingObject.prototype.move` method. Increment the `pos` by the `vel`.

### `Util`

We want to allow our classes to inherit from another. We could monkey-patch
`Function` to add an `inherits` method:

```js
Function.prototype.inherits = function (ParentClass) { ... };
```

However, monkey-patching can cause problems and should be done judiciously.
Instead, let's create a general utilities module in `lib/util.js` and add our
first utility function to it as `Util.inherits = function (childClass,
parentClass) { ... }`.

**Note:** You should export a POJO (plain old JavaScript object) from Util, not
a class. We don't need to create instances of `Util`.

```javascript
const Util = {
  inherits (childClass, parentClass) {
    //...
  }
}

module.exports = Util;
```

### `Asteroid`

Write an `Asteroid` class in a `lib/asteroid.js` file. This should inherit from `MovingObject`.

Pick a default `COLOR` and `RADIUS` for `Asteroid`s. Set these as properties of
the `Asteroid` class: `Asteroid.COLOR` and `Asteroid.RADIUS`.

Write your `Asteroid` constructor so that the caller specifies the `pos` and
calls the `MovingObject` superconstructor, setting `color` and `radius` to the
`Asteroid` defaults, and choosing a random vector for `vel`. Use the following
helper functions to help you create a random vector.

```js
// Return a randomly oriented vector with the given length.
randomVec (length) {
  const deg = 2 * Math.PI * Math.random();
  return Util.scale([Math.sin(deg), Math.cos(deg)], length);
},
// Scale the length of a vector by the given amount.
scale (vec, m) {
  return [vec[0] * m, vec[1] * m];
}
```

```js
// Other properties are filled in for you.
new Asteroid({ pos: [30, 30] });
```

Why do we still need to call `MovingObject`'s constructor function from within `Asteroid`'s constructor function?

Our `inherits` function sets up the prototype inheritance chain, which makes
methods available on the parent's prototype available to instances of the child
class. However, we still need to call `MovingObject`'s constructor function from
within `Asteroid`'s constructor function to access the code that sets properties
such as `this.pos` and `this.vel`. Its the equivalent to calling `super` in a
class's `#initialize` method in Ruby.

**Note:** Invoking an ES2015 class constructor without `new` (such as `MovingObject` with
`call()`) throws an error. Hence the need to use ES5 syntax for this project.

### `Game`

`Game` will be in charge of holding all of our moving objects. It will also
contain the logic for iterating through these objects and calling their
corresponding `move` methods.

Write an `Game` class in `lib/game.js`. Define the following constants on the
`Game` class: `DIM_X`, `DIM_Y`, and `NUM_ASTEROIDS`.

Write a `Game.prototype.addAsteroids` method. Randomly place the asteroids
within the dimensions of the game grid. You may also wish to write a
`Game.prototype.randomPosition` method. Store the asteroids in an instance
variable array `asteroids`. Call `addAsteroids` in your constructor.

Write a `Game.prototype.draw(ctx)` method. It should call `clearRect` on the
`ctx` to wipe down the entire space. Call the `draw` method on each of the
`asteroids`.

Write a `Game.prototype.moveObjects` method. It should call `move` on each of
the `asteroids`.

### `GameView`

Your `GameView` class will be responsible for keeping track of the canvas
context, the game, and the ship. Your `GameView` will be in charge of setting an
interval to animate your game. In addition, it will eventually bind key handlers
to the ship so that we can move it around.

Define an `GameView` class in `lib/game_view.js`. The `GameView` should store a
`Game` and take in and store a drawing `ctx`.

Write a `GameView.prototype.start` method. It should call `setInterval` to call
`Game.prototype.moveObjects` and `Game.prototype.draw` once every 20ms or so.

### Adding a canvas to `index.html`

In the body of your HTML file, add a `<canvas id="game-canvas">` tag with the
width and height you defined in `Game`.

### Create your entry file Create a new file called `asteroids.js`.

In the file, add an event listener for the `DOMContentLoaded` event. Within the
callback, use `document.getElementById()` to find the canvas element. Call
`getContext` on the canvas element with "2d" as the argument to extract a canvas
context.

Once you have your canvas context, construct a `GameView` object and call
`GameView.prototype.start`.

This is your webpack entry point, so start webpack (or restart it, if you're
already running webpack --watch) with the "asteroids.js" file as your new entry
point.

Your asteroids should fly around :-)

## Phase IIa: Wrapping Asteroids

Currently your asteroids slide off the screen. We'd like to keep everything
within the dimensions of the game's rectangular view by mapping opposite sides
of the grid view. If an asteroid scrolls off one side, it should reappear on the
other. Write a `Game.prototype.wrap(pos)` method, which takes a `pos` in and
returns a "wrapped position".

Next, change your calls of `new Asteroid` to pass in the `game` as one of the
`options`. In `MovingObject`, store the `game`. Update your
`MovingObject.prototype.move` method to call `Game.prototype.wrap` on `this.pos`
each time.

Check that your `Asteroid`s don't all fly away, but instead wrap like they are
supposed to.

## Phase IIb: Colliding Asteroids

A big part of Asteroids is the collision of objects: ships collide with
asteroids, bullets collide with asteroids. To start, let's implement asteroids
colliding with asteroids.

Write a `MovingObject.prototype.isCollidedWith(otherObject)` method. Two circles
have collided if the distance between their center points is less than the sum
of their radii.

Next, write a `Game.prototype.checkCollisions` that iterates through the
asteroids and `alert("COLLISION");` whenever two collide. Make sure not to check
if an asteroid collides with itself.

Write a `Game.prototype.step` method, which calls `Game.prototype.moveObjects`
then `Game.prototype.checkCollisions`. Call this in `GameView.prototype.start`
instead of `moveObjects` directly.

**Check your work**. This shouldn't be too hard if you reduce
`Game.NUM_ASTEROIDS = 4` or so.

Last: when an asteroid crashes into another, let's remove both asteroids. Write
`Game.prototype.remove(asteroid)` and
`MovingObject.prototype.collideWith(otherObject)`. In
`MovingObject.prototype.collideWith(otherObject)`, call `Game.prototype.remove`
on both objects.

We'll change this soon, but we want to have collision and removal logic working.
**Check that when two asteroids collide, they both go away**.

## Phase IIIa: `Ship`

In `lib/ship.js`, write an `Ship` class; this should be another subclass of
`MovingObject`. Define `Ship.RADIUS` and `Ship.COLOR` as before. I default
initialize the `vel` to the zero vector.

In your `Game` constructor, build a `Ship` object. I used
`Game.prototype.randomPosition` to place the `Ship`. Save your ship to an
instance variable.

I wrote a `Game.prototype.allObjects` method that returned the array of
`Asteroid`s + the ship. I iterated through this in `Game.prototype.draw`,
`Game.prototype.moveObjects`, and `Game.prototype.checkCollisions`

Update the `MovingObject.prototype.collideWith(otherObject)` logic. Stop
removing colliding asteroids; your `MovingObject.prototype.collideWith` should
be empty. Instead, overwrite the superclass's method with
`Asteroid.prototype.collideWith(otherObject)`: if `otherObject instanceof Ship`,
call `Ship.prototype.relocate`. The `Ship.prototype.relocate` method should
reset the `Ship`'s position to `game.randomPosition()` and reset velocity to the
zero vector.

## Phase IIIb: Moving the ship

Add a `Ship.prototype.power(impulse)`. The impulse should be added to the
current velocity of the ship.

Add a `GameView.prototype.bindKeyHandlers` method. Check out the
[`keymaster`][keymaster] library. You should include `keymaster.js` in your
javascripts folder and use a `script src` tag to require it above your
`bundle.js` file. The `keymaster` library will expose a global method `key`
which takes a key and a callback that will be triggered when the key is pressed.
Use it to bind keys to call `Ship.prototype.power` on the game's `ship`. Call
your `bindKeyHandlers` method in `GameView.prototype.start`.

[keymaster]: https://github.com/madrobby/keymaster

## Phase IVa: Firing `Bullet`s

Write a `Bullet` subclass of `MovingObject`. The idea is that when a
`Bullet.prototype.collideWith` an `Asteroid`, we'll remove the `Asteroid` from
the `Game`.

The key is `Ship.prototype.fireBullet`. This should:

0. Construct a new `Bullet` instance.
0. You will want to use the `Ship`s `vel` as the direction of travel of the
bullet.
0. Add the bullet to an array of `Game` bullets.

`Game` should store an array of `Bullet`s just like `Asteroid`s. To make my life
easier, I wrote a `Game.prototype.add(obj)` method that added to
`this.asteroids`/`this.bullets` if `obj instanceof Asteroid`/`obj instanceof
Bullet`. I wrote a similar `Game.prototype.remove(obj)` method. This was easier
than having two methods each for `Asteroid` and `Bullet`.

Update your `Game.prototype.allObjects` as well.

Update `GameView.prototype.addKeyBindings` to bind a key to
`Ship.prototype.fireBullet`.

Write the override of `Bullet.prototype.collideWith`.

## Phase V: Cleaning up objects

Your `Bullet` should not wrap like other objects. When it leaves the visible
grid, it should be removed.

Write a `Game.prototype.isOutOfBounds(pos)` to return `true` if an object slips
off screen.

Define a property `MovingObject.prototype.isWrappable = true`. However, you can
overwrite this in `Bullet` to be false.

In `MovingObject.prototype.move`, after updating the position, check if the
object is out of bounds. If so, either (A) wrap the object if it `isWrappable`
or (B) call `Game.prototype.remove` if not.

## Phase VI (Bonus): Drawing an image

Often times people want to draw a background image on their game.

```javascript
const img = new Image();
img.onload = function () {
  ctx.drawImage(img, xOffset, yOffset);
};
img.src = 'myImage.png';
```

Note you may have to redraw the background each iteration. You do not need to
constantly reload the `img`; just make sure to `ctx.drawImage` each frame.

## Phase VII (Bonus): RequestAnimationFrame

We are going to have our game use `requestAnimationFrame`. Go to the console and
type this in. Notice that it is the global namespace. It provides a better way
to do animations. Read more
[here](https://developer.mozilla.org/en-US/docs/Web/API/window/requestAnimationFrame).

### Phase VIIb: MovingObject

Rewrite your `move` method, this time allowing it to take in a `timeDelta`.
Increment the `pos` by the `vel * delta`. The delta will be created in the
GameView's `animate` method based on the time variable provided by
`window.requestAnimationFrame`. Until we define that method, default `delta` to
a value of 1. You can default a value using the logical OR operator `delta =
delta || 1`.

### Phase VIIc: Game

Refactor your `Game.prototype.moveObjects(delta)` method. It should the `delta`
to each `Asteroid.prototype.move`.

### Phase VIIa: GameView

The `GameView` should now store a `lastTime` instance variable. It will be used
to derive the delta (default it to `0`).

Write a `GameView.prototype.animate` method. It should:

* Create a `delta` variable. It represents the difference between the last time
`animate` was called and the current call to `animate`. The current time will
be passed to the animate function as a parameter.

* Call `requestAnimationFrame`, passing in the `GameView.prototype.animate`.
Yes, this is recursive. Each frame calls the next.

* Call `Game.prototype.moveObjects(delta)` and `Game.prototype.draw(ctx)`

* Update `this.lastTime` to be equal to the current time;

Refactor your `GameView.prototype.start` method. It will make the first call to
`requestAnimationFrame`, passing in the `GameView.prototype.animate`.

**NB**: You'll notice that all of your moving objects are moving way too fast.
Go back to `MovingObject.prototype.move` and divide the delta by some number
before adding it to the velocity. Your code might look something like:

```js
const velX = this.vel[0] * delta / 20;
const velY = this.vel[1] * delta / 20;

this.pos = [this.pos[0] + velX, this.pos[1] + velY];
```

## Resources

* [Canvas tutorial](https://developer.mozilla.org/en-US/docs/HTML/Canvas/Tutorial?redirectlocale=en-US&redirectslug=Canvas_tutorial)
* [Canvas docs](https://developer.mozilla.org/en-US/docs/HTML/Canvas)
* [Legend](http://asteroids.aaronik.com/)
