const readline = require("readline");

const reader = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});

class Game {
  constructor() {
    this.towers = [[3, 2, 1], [], []];
  }

  run() {
    // until game over
    // get move from player (from, to)
    // make the move
  }

  promptMove() {
    // print the stacks
    console.log(this.towers);
    // get move from user

    // run callback with fromIndex and toIndex
  }

  getMove() {
    reader.question("Which tower will you move from?: ", function(from) {
      reader.question("Which tower will you move to?: ", function(to) {
        const fromIndex = parseInt(from);
        const toIndex = parseInt(to);
      });
    });
  }

  isValidMove(fromIndex, toIndex) {
    if (this.towers[fromIndex].length === 0) {
      return false;
    }
    let towerFrom = this.towers[fromIndex];
    let towerTo = this.towers[toIndex];

    if (towerTo.length !== 0) {
      let diskFrom = towerFrom.slice(-1);
      let diskTo = towerTo.slice(-1);
      if (diskFrom > diskTo) return false;
    }
    return true;
  }
}

const game = new Game();
console.log(game.isValidMove(1, 2));
