require 'byebug'

require_relative 'board'

class Game
  attr_accessor :board

  def initialize(board)
    @board = board
  end

  def play
    single_round until @board.solved?
  end

  def solver
    puts "Original:"
    @board.render

    if solve(0,0) # start at 0 0 (conner left up)
      print_result
    else
      puts "There is No Solution for the board :("
    end
  end

  private

  def single_round
    @board.render
    prompt
    pos, value = get_input
    until check_move(pos, value)
      pos, value = get_input
    end
    @board.update_tile(pos, value)
    # puts "#{@board[[1,0]]} soidjhfosjdfhosjfd"
  end


  def solve(rowIndex, colIndex)

    if rowIndex == Board::BOARD_SIZE
      colIndex += 1 # at the end of the row --> increment the column to 1

      # The end of the board (conner right) --> Finished
      return true if colIndex == Board::BOARD_SIZE

      rowIndex = 0 # reset the rowIndex to 0 for the next column
    end

    if @board[[rowIndex, colIndex]] != 0
      return solve(rowIndex + 1, colIndex)
    end

    (1..Board::BOARD_SIZE).each do |n|
      if @board.checker([rowIndex, colIndex], n)
        @board[[rowIndex, colIndex]] = n

        if solve(rowIndex + 1, colIndex)
          return true
        end
      end

      # BackTracking
      @board[[rowIndex, colIndex]]  = 0
    end

    false
  end

  def print_result
    puts "\nResult:"
    @board.render
  end

  def get_input
    input = gets.chomp.split(' ').map(&:to_i)
    pos = [input[0], input[1]]
    value = input[-1]
    [pos, value]
  end

  def check_move(pos, value)
    if !@board.checker(pos, value)
      puts "Invalid move, please retry"
      return false
    end
    true
  end

  def prompt
    puts "Enter a position (0-8) with a value (1-9), i.e ( 4 6 9 ):"
  end
end

if __FILE__ == $0
  file = 'puzzles/sudoku3.txt'
  board = Board.new(file)
  game = Game.new(board)
  # game.play
  game.solver
end

=begin

sudoku3.txt

Original:

   0  0  0    0  0  0    9  0  7
   0  0  0    4  2  0    1  8  0
   0  0  0    7  0  5    0  2  6

   1  0  0    9  0  4    0  0  0
   0  5  0    0  0  0    0  4  0
   0  0  0    5  0  7    0  0  9

   9  2  0    1  0  8    0  0  0
   0  3  4    0  5  9    0  0  0
   5  0  7    0  0  0    0  0  0

Result:

   4  6  2    8  3  1    9  5  7
   7  9  5    4  2  6    1  8  3
   3  8  1    7  9  5    4  2  6

   1  7  3    9  8  4    2  6  5
   6  5  9    3  1  2    7  4  8
   2  4  8    5  6  7    3  1  9

   9  2  6    1  7  8    5  3  4
   8  3  4    2  5  9    6  7  1
   5  1  7    6  4  3    8  9  2

=end
