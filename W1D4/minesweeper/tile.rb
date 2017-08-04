# require_relative

class Tile
  attr_accessor :value
  attr_reader :board

  def initialize(value="-", board)
    @value = value
    @board = board
  end

  def to_s
    @value.to_s
  end

  def neighbors_bomb_count
    return []
  end

  def []()
    @value
  end
end
