require 'colorize'
require 'byebug'
require_relative 'piece'

class Board
  attr_reader :grid

  BOARD_SIZE = 8
  BACK_ROW = [ Rook, Knight, Bishop, Queen, King, Bishop, Knight, Rook ]
  FRONT_ROW =

  def initialize
    @grid = Array.new(BOARD_SIZE) { Array.new(BOARD_SIZE, NullPiece.new)   }
    populate
    render
  end

  def populate

    (0...BOARD_SIZE).each { |i| self.add(BACK_ROW[i], 0, i) }
    (0...BOARD_SIZE).each { |i| self.add(Rook, 1, i) }

    (0...BOARD_SIZE).each { |i| self.add(BACK_ROW[i], (BOARD_SIZE - 1), i) }
    (0...BOARD_SIZE).each { |i| self.add(Rook, (BOARD_SIZE - 2), i) }

  end

  def add(piece_class, i, j)
    @grid[i][j] = piece_class.new([i,j], self)
  end

  def move_piece(start_pos, end_pos)
    begin
      valid_move?(start_pos, end_pos)
    rescue ArgumentError => e
      return e.message
    end

    self[start_pos], self[end_pos] = self[end_pos], self[start_pos]
    render
  end

  def valid_move?(start_pos, end_pos)
    x, y = start_pos

    x_valid = x.between?(0,BOARD_SIZE-1)
    y_valid = y.between?(0,BOARD_SIZE-1)
    if !x_valid || !y_valid
      return raise ArgumentError.new("Start position out of boundaries.")
    end
    if self[start_pos].type == "O"
      return raise ArgumentError.new("You don't have a piece here.")
    end

    x, y = end_pos

    x_valid = x.between?(0,BOARD_SIZE-1)
    y_valid = y.between?(0,BOARD_SIZE-1)
    if !x_valid || !y_valid
      return raise ArgumentError.new("End position out of boundaries.")
    end
    if self[end_pos].type == "O"
      return raise ArgumentError.new("You already have a piece here.")
    end

    true
  end

  def [](pos)
    x, y = pos
    @grid[x][y]
  end

  def []=(pos, value)
    x, y = pos
    @grid[x][y] = value
  end

  def render
    (0...BOARD_SIZE).each do |i|
      (0...BOARD_SIZE).each do |j|
        print " #{@grid[i][j]} "
      end
      puts ""
    end
  end
end

b = Board.new
