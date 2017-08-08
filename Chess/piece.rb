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
