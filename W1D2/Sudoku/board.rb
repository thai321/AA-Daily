require_relative 'tile'

class Board
  attr_accessor :grid
  BOARD_SIZE = 9
  BOX_SIZE = 3

  def initialize(file)
    @grid = Board.from_file(file)
  end

  def [](pos)
    x,y = pos
    @grid[x][y]
  end

  def []=(pos, value)
    x,y = pos
    @grid[x][y] = value
  end

  def run
    render
    p solved?
  end

  def solved?
    @grid.all? { |row| row.all? { |tile| tile != 0 }  }
  end

  def checker(pos, value)
    x, y = pos

    # check row, and column
    0.upto(BOARD_SIZE-1) do |i|
      return false if (@grid[x][i] == value && i != y) # column
      return false if (@grid[i][y] == value && i != x) # row
    end

    # Check to see if given number n is already in the box
    # 0: 0,1,2 --> offset = 0
    # 1: 3,4,5 --> offset = 3
    # 2: 6,7,8 --> offset = 6
    xOffset = (x/BOX_SIZE) * BOX_SIZE
    yOffset = (y/BOX_SIZE) * BOX_SIZE
    (0...BOX_SIZE).each do |i|
      (0...BOX_SIZE).each do |j|
        return false if (@grid[xOffset + i][yOffset + j] == value)
      end
    end

    true
  end

  def render
    (0...BOARD_SIZE).each do |i|
      puts '' if i % 3 == 0
      (0...BOARD_SIZE).each do |j|
        print '  ' if j % 3 == 0
        print " #{@grid[i][j]} "
      end
      puts ''
    end
  end

  private

  def self.from_file(file)
     arr_2D = File.readlines(file).map(&:chomp)
     result = Array.new(BOARD_SIZE) { Array.new{ BOARD_SIZE } }
     BOARD_SIZE.times do |i|
       BOARD_SIZE.times do |j|
         result[i][j] = arr_2D[i][j].to_i
       end
     end
     result
  end

  def update_tile(pos, value)
    x,y = pos
    @grid[x][y] = value
  end

end
