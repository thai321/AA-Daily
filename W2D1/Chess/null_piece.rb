require 'singleton'

class NullPiece < Piece

  include Singleton

  def initialize

  end

  def symbol
    " "
  end

  def to_s
    "#{symbol}".to_s
  end

end
