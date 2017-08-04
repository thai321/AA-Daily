require_relative 'tile'

class Board
  BOARD_SIZE = 9
  BOM_NUM = 30
  attr_accessor :grid

  def initialize
    @grid = Array.new(BOARD_SIZE) {Array.new(BOARD_SIZE)}
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
        print " #{@grid[i][j].value} "
      end
      puts ""
    end
  end

  def populate_board

    (BOARD_SIZE * 3).times do
      x = rand(BOARD_SIZE)
      y = rand(BOARD_SIZE)
      @grid[x][y] = Tile.new("*", self)
    end

    (0...BOARD_SIZE).each do |i|
      (0...BOARD_SIZE).each do |j|
        @grid[i][j] = Tile.new(0, self) if @grid[i][j].nil?
      end
    end

  end

end
