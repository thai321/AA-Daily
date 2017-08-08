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

  def color_at(pos)
    if pos == @cursor.cursor_pos && @cursor.selected
      { :background => :red }
    elsif pos == @cursor.cursor_pos
      { :background => :green }
    elsif pos[0].even? && pos[1].even?
      { :background => :white }
    elsif pos[0].even? && pos[1].odd?
      { :background => :black }
    elsif pos[0].odd? && pos[1].even?
      { :background => :black }
    elsif pos[0].odd? && pos[1].odd?
      { :background => :white }
    end
  end

  def render
    system('clear')
    @board.grid.each_with_index do |row, i|
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
game.move_cursor
