/******/ (function(modules) { // webpackBootstrap
/******/ 	// The module cache
/******/ 	var installedModules = {};
/******/
/******/ 	// The require function
/******/ 	function __webpack_require__(moduleId) {
/******/
/******/ 		// Check if module is in cache
/******/ 		if(installedModules[moduleId]) {
/******/ 			return installedModules[moduleId].exports;
/******/ 		}
/******/ 		// Create a new module (and put it into the cache)
/******/ 		var module = installedModules[moduleId] = {
/******/ 			i: moduleId,
/******/ 			l: false,
/******/ 			exports: {}
/******/ 		};
/******/
/******/ 		// Execute the module function
/******/ 		modules[moduleId].call(module.exports, module, module.exports, __webpack_require__);
/******/
/******/ 		// Flag the module as loaded
/******/ 		module.l = true;
/******/
/******/ 		// Return the exports of the module
/******/ 		return module.exports;
/******/ 	}
/******/
/******/
/******/ 	// expose the modules object (__webpack_modules__)
/******/ 	__webpack_require__.m = modules;
/******/
/******/ 	// expose the module cache
/******/ 	__webpack_require__.c = installedModules;
/******/
/******/ 	// define getter function for harmony exports
/******/ 	__webpack_require__.d = function(exports, name, getter) {
/******/ 		if(!__webpack_require__.o(exports, name)) {
/******/ 			Object.defineProperty(exports, name, {
/******/ 				configurable: false,
/******/ 				enumerable: true,
/******/ 				get: getter
/******/ 			});
/******/ 		}
/******/ 	};
/******/
/******/ 	// getDefaultExport function for compatibility with non-harmony modules
/******/ 	__webpack_require__.n = function(module) {
/******/ 		var getter = module && module.__esModule ?
/******/ 			function getDefault() { return module['default']; } :
/******/ 			function getModuleExports() { return module; };
/******/ 		__webpack_require__.d(getter, 'a', getter);
/******/ 		return getter;
/******/ 	};
/******/
/******/ 	// Object.prototype.hasOwnProperty.call
/******/ 	__webpack_require__.o = function(object, property) { return Object.prototype.hasOwnProperty.call(object, property); };
/******/
/******/ 	// __webpack_public_path__
/******/ 	__webpack_require__.p = "";
/******/
/******/ 	// Load entry module and return exports
/******/ 	return __webpack_require__(__webpack_require__.s = 2);
/******/ })
/************************************************************************/
/******/ ([
/* 0 */
/***/ (function(module, exports) {

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

    return Math.floor(
      Math.sqrt(Math.pow(x_1 - x_2, 2) + Math.pow(y_1 - y_2, 2))
    );
  },

  norm(pos) {
    return this.distance([0, 0], pos);
  },

  changePos(point, dim) {
    if (point > dim) return point % dim;
    else if (point < 0) return dim - point % dim;
    return point;
  }
};

module.exports = Util;


/***/ }),
/* 1 */
/***/ (function(module, exports, __webpack_require__) {

const Asteroid = __webpack_require__(4);
const Util = __webpack_require__(0);

Game.DIM_X = 800;
Game.DIM_Y = 800;
Game.NUM_ASTEROIDS = 10;
// Game.DIRS = [[0, 1], [0, -1], [1, 0], [-1, 0]];

function Game() {
  this.asteroids = [];
  this.addAsteroids();
}

Game.prototype.addAsteroids = function addAsteroids() {
  // Call randomPosition
  for (let i = 0; i < Game.NUM_ASTEROIDS; i++) {
    const asteroid = new Asteroid({
      pos: this.randomPosition(),
      game: this
    });
    this.asteroids.push(asteroid);
  }
};

Game.prototype.randomPosition = function randomPosition() {
  const x = Math.floor(Math.random() * Game.DIM_X);
  const y = Math.floor(Math.random() * Game.DIM_Y);
  return [x, y];
};

Game.prototype.draw = function draw(ctx) {
  // void ctx.clearRect(x, y, width, height);
  // call draw method on each of the asteroid
  ctx.clearRect(0, 0, Game.DIM_X, Game.DIM_Y);
  ctx.fillStyle = 'black';
  ctx.fillRect(0, 0, Game.DIM_X, Game.DIM_Y);

  this.asteroids.forEach(asteroid => {
    asteroid.draw(ctx);
  });
};

Game.prototype.moveObjects = function moveObject() {
  // call move on each of the asteroids

  this.asteroids.forEach(asteroid => {
    asteroid.move(asteroid.vel);
  });
};

Game.prototype.wrap = function wrap(pos) {
  const x = Util.changePos(pos[0], Game.DIM_X);
  const y = Util.changePos(pos[1], Game.DIM_Y);

  return [x, y];
};

Game.prototype.checkCollisions = function checkCollisions() {
  for (let i = 0; i < this.asteroids.length; i++) {
    for (let j = 0; j < this.asteroids.length; j++) {
      if (i !== j) {
        const asteroid1 = this.asteroids[i];
        const asteroid2 = this.asteroids[j];
        if (asteroid1.isCollidedWith(asteroid2)) {
          alert('COLLISION');
          const i = this.asteroids.indexOf(asteroid1);
          this.remove(i);
          const j = this.asteroids.indexOf(asteroid2);
          this.remove(j);
          // debugger;
          return;
        }
      }
    }
  }
};

Game.prototype.remove = function remove(i) {
  this.asteroids.splice(i, 1);
};

Game.prototype.step = function step() {
  this.moveObjects();
  this.checkCollisions();
};

module.exports = Game;


/***/ }),
/* 2 */
/***/ (function(module, exports, __webpack_require__) {

const GameView = __webpack_require__(3);
const Game = __webpack_require__(1);

document.addEventListener('DOMContentLoaded', function() {
  const canvas = document.getElementById('game-canvas');
  canvas.width = Game.DIM_X;
  canvas.height = Game.DIM_Y;

  const ctx = canvas.getContext('2d');

  const game = new Game();

  const gameView = new GameView(game, ctx);
  gameView.start();
});


/***/ }),
/* 3 */
/***/ (function(module, exports, __webpack_require__) {

const Game = __webpack_require__(1);

function GameView(game, ctx) {
  this.game = game;
  this.ctx = ctx;
}

GameView.prototype.start = function start() {
  // Call setInterval to call Game.prototype.moveObjects
  // and Game.prototype.draw once every 20ms or so

  setInterval(() => {
    // this.game.moveObjects(DIRS[i]);
    this.game.step();
    this.game.draw(this.ctx);
  }, 300);
};

module.exports = GameView;


/***/ }),
/* 4 */
/***/ (function(module, exports, __webpack_require__) {

const MovingObject = __webpack_require__(5);
const Util = __webpack_require__(0);

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


/***/ }),
/* 5 */
/***/ (function(module, exports, __webpack_require__) {

const Util = __webpack_require__(0);

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
  ctx.arc(x, y, this.radius + 1, 0, 2 * Math.PI, true);

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


/***/ })
/******/ ]);