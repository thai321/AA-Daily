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
  attr_reader :type

  def initialize(type)
    @type = type
  end

  def to_s
    @type.to_s
  end
end

class NullPiece < Piece

  def initialize
    super("-")
  end

end

class King < Piece
end

class Queen < Piece
  include SlidingPiece
end

class Bishop < Piece
  include SlidingPiece

  def move_dirs
    # only diagonally (increase/decrease x and y by the same amount)
  end

end

class Knight < Piece

end

class Rook < Piece
  include SlidingPiece

  def move_dirs
    # Move horizontally or vertically
  end

end

class Pawn < Piece
end
