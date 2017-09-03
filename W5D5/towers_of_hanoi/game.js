const readline = require('readline');

const reader = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});

class Game {
  constructor() {
    this.towers = [[3, 2, 1], [], []];
  }

  run(reader, completionCallBack) {
    // until game over
    this.promptMove(reader, (fromIndex, toIndex) => {
      if (this.move(fromIndex, toIndex) && this.isWon()) {
        completionCallBack();
        return;
      } else {
        console.log('Invalid Move! try again');
      }
      this.run(reader, completionCallBack);
    });
  }

  promptMove(reader, callback) {
    // print the stacks
    console.log(this.towers);

    // get move from user
    reader.question('Which tower will you move from?: ', function(from) {
      reader.question('Which tower will you move to?: ', function(to) {
        const fromIndex = parseInt(from);
        const toIndex = parseInt(to);

        // run callback with fromIndex and toIndex
        callback(fromIndex, toIndex);
      });
    });
  }

  move(fromIndex, toIndex) {
    if (this.isValidMove(fromIndex, toIndex)) {
      this.towers[toIndex].push(this.towers[fromIndex].pop());
      return true;
    } else {
      return false;
    }
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

  isWon() {
    return this.towers[1].length == 3 || this.towers[2].length == 3;
  }
}

function completionCallBack() {
  console.log('You Won');
  reader.close();
}

const game = new Game();
game.run(reader, completionCallBack);
