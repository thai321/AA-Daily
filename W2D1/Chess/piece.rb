require 'colorize'

module SlidingPiece

  HORIZONTAL = [
    [1,0],
    [-1,0]
  ]

  VERTICAL = [
    [0, 1],
    [0, -1]
  ]

  DIAGONAL = [
    [1,1],
    [1, -1],
    [-1, -1],
    [-1, 1]
  ]


  def move_dirs
  end

end

class Piece
  attr_reader :type, :board
  attr_accessor :pos

  def initialize(pos, board)
    # @type = type
    @pos = pos
    @board = board
  end

  def to_s
    "#{symbol}"
  end

  def symbol
    " A Symbol "
  end
end

class NullPiece

  # include Singleton

  # def initialize
  #   # super("-")
  # end

  def symbol
    "-"
  end

  def to_s
    "#{symbol}".to_s
  end

end

class King < Piece

  def symbol
    "K"
  end

  def to_s
    symbol.colorize(:color => :red )
  end
end

class Queen < Piece
  include SlidingPiece

  def symbol
    "Q"
  end

end

class Bishop < Piece
  include SlidingPiece

  def move_dirs
    # only diagonally (increase/decrease x and y by the same amount)
  end


  def symbol
    "B"
  end

end

class Knight < Piece

  def symbol
    "N"
  end

end

class Rook < Piece
  include SlidingPiece

  def symbol
    "R"
  end

  def move_dirs
    # Move horizontally or vertically
  end

end

class Pawn < Piece


  def symbol
    "P"
  end

end
