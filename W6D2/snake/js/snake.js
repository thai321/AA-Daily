class Snake {
  const DIRECTIONS = ["N", "E", "S", "W"];

  constructor() {
    this.direction = "N";
    this.segments = [[]];
  }

  move(){
    // move to current direction
  }

  turn(key) {

  }


}


class Board {
  constructor() {
    this.snake = new Snake();
  }


}


module.exports = Board;
