require 'colorize'

require_relative 'cursor'
require_relative 'board'

class Display
  attr_accessor :board

  def initialize(board)
    @board = board
    @cursor = Cursor.new([0,0], board)
  end

  def move_cursor
    while true
      render
      pos = @cursor.get_input
    end
  end

  def render
    system('clear')
    (0...Board::BOARD_SIZE).each do |i|
      (0...Board::BOARD_SIZE).each do |j|
        if [i,j] == @cursor.cursor_pos
          print " #{board.grid[i][j]} ".colorize(:red)
        else
          print " #{board.grid[i][j]} "
        end
      end
      puts ""
    end
  end

end

b = Board.new
game = Display.new(b)
game.move_cursor

# game.cursor.get_input
  # game.render
