let Piece = require("./piece");

/**
 * Returns a 2D array (8 by 8) with two black pieces at [3, 4] and [4, 3]
 * and two white pieces at [3, 3] and [4, 4]
 */
function _makeGrid() {
  const grid = [
    [[], [], [], [], [], [], [], []],
    [[], [], [], [], [], [], [], []],
    [[], [], [], [], [], [], [], []],
    [[], [], [], [], [], [], [], []],
    [[], [], [], [], [], [], [], []],
    [[], [], [], [], [], [], [], []],
    [[], [], [], [], [], [], [], []],
    [[], [], [], [], [], [], [], []]
  ];

  grid.forEach(row => {
    row.forEach(col => {
      col = new Piece("Null");
    });
  });

  grid[3][4] = new Piece("Black");
  grid[4][3] = new Piece("Black");
  grid[3][3] = new Piece("White");
  grid[4][4] = new Piece("White");

  return grid;
}

/**
 * Constructs a Board with a starting grid set up.
 */
function Board() {
  this.grid = _makeGrid();
}

Board.DIRS = [
  [0, 1],
  [1, 1],
  [1, 0],
  [1, -1],
  [0, -1],
  [-1, -1],
  [-1, 0],
  [-1, 1]
];

/**
 * Returns the piece at a given [x, y] position,
 * throwing an Error if the position is invalid.
 */
Board.prototype.getPiece = function(pos) {
  const x = pos[0];
  const y = pos[1];
  if (x > 7 || y > 7) throw "Invalid Position";
  return this.grid[x][y];
};

/**
 * Checks if there are any valid moves for the given color.
 */
Board.prototype.hasMove = function(color) {};

/**
 * Checks if the piece at a given position
 * matches a given color.
 */
Board.prototype.isMine = function(pos, color) {
  return this.getPiece(pos).color === color;
};

/**
 * Checks if a given position has a piece on it.
 */
Board.prototype.isOccupied = function(pos) {
  return this.getPiece(pos).color !== "Null";
};

/**
 * Checks if both the white player and
 * the black player are out of moves.
 */
Board.prototype.isOver = function() {};

/**
 * Checks if a given position is on the Board.
 */
Board.prototype.isValidPos = function(pos) {
  const x = pos[0];
  const y = pos[1];
  x > 7 || y > 7 ? false : true;
};

/**
 * Recursively follows a direction away from a starting position, adding each
 * piece of the opposite color until hitting another piece of the current color.
 * It then returns an array of all pieces between the starting position and
 * ending position.
 *
 * Returns null if it reaches the end of the board before finding another piece
 * of the same color.
 *
 * Returns null if it hits an empty position.
 *
 * Returns null if no pieces of the opposite color are found.
 */
function _positionsToFlip(board, pos, color, dir, piecesToFlip) {
  startingPos = pos;

  Board.DIRS.forEach((direction) => {
    while
  });
}

/**
 * Adds a new piece of the given color to the given position, flipping the
 * color of any pieces that are eligible for flipping.
 *
 * Throws an error if the position represents an invalid move.
 */
Board.prototype.placePiece = function(pos, color) {};

/**
 * Prints a string representation of the Board to the console.
 */
Board.prototype.print = function() {};

/**
 * Checks that a position is not already occupied and that the color
 * taking the position will result in some pieces of the opposite
 * color being flipped.
 */
Board.prototype.validMove = function(pos, color) {};

/**
 * Produces an array of all valid positions on
 * the Board for a given color.
 */
Board.prototype.validMoves = function(color) {};

module.exports = Board;
