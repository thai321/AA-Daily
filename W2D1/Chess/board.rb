require 'colorize'
require 'byebug'

require_relative 'pieces'

class Board
  attr_reader :grid

  BOARD_SIZE = 8
  BACK_ROW = [ Rook, Knight, Bishop, Queen, King, Bishop, Knight, Rook ]
  WHITE_CODES = [ "\u2656", "\u2658" , "\u2657" , "\u2655" , "\u2654" , "\u2657" , "\u2658" , "\u2656"  ]
  BLACK_CODES = [ "\u265C", "\u265E" , "\u265D" , "\u265B" , "\u265A" , "\u265D" , "\u265E" , "\u265C"  ]
  WHITE_PAWN = "\u2659"
  BLACK_PAWN = "\u265F"


  def initialize
    @grid = Array.new(BOARD_SIZE) { Array.new(BOARD_SIZE, NullPiece.instance) }
    populate
    render
  end

  def populate

    (0...BOARD_SIZE).each { |i| self.add(BACK_ROW[i], 0, i, BLACK_CODES[i], :black) }
    (0...BOARD_SIZE).each { |i| self.add(Pawn, 1, i, BLACK_PAWN, :black) }
    # @grid[4][4] = Rook.new([4, 4], self, "\u2656", :white)
    # @grid[3][3] = Pawn.new([3, 3], self, "\u265F", :black)

    (0...BOARD_SIZE).each { |i| self.add(BACK_ROW[i], (BOARD_SIZE - 1), i, WHITE_CODES[i], :white) }
    (0...BOARD_SIZE).each { |i| self.add(Pawn, (BOARD_SIZE - 2), i, WHITE_PAWN, :white) }

  end

  def add(piece_class, i, j, code, color)
    @grid[i][j] = piece_class.new([i,j], self, code, color)
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

  def in_check?(color)
    (0...BOARD_SIZE).each do |i|
      (0...BOARD_SIZE).each do |j|
        opponent_piece = self[[i, j]]
        if !opponent_piece.is_a?(NullPiece) && color != opponent_piece.color
          moves = opponent_piece.moves
          return true if check_for_king?(moves, opponent_piece.color)
        end
      end
    end
    false
  end

  def check_for_king?(moves, opponent_color)
    moves.any? do |move|
      x, y = move
      @grid[x][y].class == King && opponent_color != @grid[x][y].color
    end
  end

  def checkmate?(color)
    return false if !in_check(color)

    pieces_color = all_pieces.select { |piece| piece.color == color }

    pieces_color.all? { |piece| piece.valid_moves.empty?  }
  end

  def all_pieces
    @grid.flaten.reject { |piece| piece.empty?  }
  end
end
