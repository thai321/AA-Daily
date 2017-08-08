require_relative 'card'
class Board
  attr_accessor :grid
  GRIDSIZE = 6

  def initialize
    @grid = Array.new(GRIDSIZE) { Array.new(GRIDSIZE) }
    @values = ((1..GRIDSIZE*GRIDSIZE/2).to_a * 2).shuffle
    populate
  end

  def reveal(guess_pos)
    self[guess_pos].reveal
    self[guess_pos].value
  end

  def won?
    @grid.each do |subarray|
      subarray.each do |card|
        return false unless card.face_up
      end
    end
    true
  end

  def populate
    @grid.map! do |subarray|
      subarray.map! do |el|
        Card.new(@values.pop)
      end
    end
  end

  def render
    @grid.each do |subarray|
      subarray.each do |card|
        print card.face_up ? card : ":)"
      end
      puts ''
    end
  end

  def [](pos)
    x,y = pos
    @grid[x][y]
  end

  def []=(pos,value)
    x,y = pos
    @grid[x][y] = value
  end

end

# if __FILE__ == $0
#   a = Board.new
#   a.populate
#   a.render
# end
