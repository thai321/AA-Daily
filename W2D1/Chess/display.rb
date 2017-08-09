require 'colorize'

require_relative 'cursor'
require_relative 'board'

class Display
  attr_accessor :board

  def initialize(board)
    @board = board
    @cursor = Cursor.new([0,0], board)
    render
  end

  def move_cursor
    while true
      render
      pos = @cursor.get_input
    end
  end

  def color_at(pos)
    if pos == @cursor.cursor_pos && @cursor.selected
      { :background => :red }
    elsif pos == @cursor.cursor_pos
      { :background => :green }
    elsif pos[0].even? && pos[1].even?
      { :background => :gray }
    elsif pos[0].even? && pos[1].odd?
      { :background => :white }
    elsif pos[0].odd? && pos[1].even?
      { :background => :white }
    elsif pos[0].odd? && pos[1].odd?
      { :background => :gray }
    end
  end

  def render
    system('clear')

    puts "   0  1  2  3  4  5  6  7"
    @board.grid.each_with_index do |row, i|
      print "#{i} "
      row.each_with_index do |piece, j|
        color = color_at([i,j])
        print " #{board.grid[i][j]} ".colorize(color)
      end
      puts ""
    end
  end
end

b = Board.new
game = Display.new(b)
rook = b.grid[4][4]
pawn2 = b.grid[3][3]
# p pawn2.color
# game.move_cursor
p rook.moves
p b.in_check?(:black)
# game.board[]
