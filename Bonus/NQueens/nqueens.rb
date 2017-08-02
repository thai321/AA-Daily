class NQueens
  attr_accessor :chessTable
  attr_reader :numQueens

  def initialize(queens)
    @numQueens = queens
    @chessTable = make_2d_array(@numQueens)
  end

  def solve
    if(setQueens(0))
      puts "There is solution for #{@numQueens} queens problem"
      print_solution
    else
      puts "No Solution for #{@numQueens} queens problem"
    end
  end

  private

  def setQueens(colIndex)
    return true if(colIndex == @numQueens)

    (0...@numQueens).each do |rowIndex|
      if(is_place_valid?(rowIndex, colIndex))
        @chessTable[rowIndex][colIndex] = 'Q'

        return true if setQueens(colIndex + 1)

        # BACKTRACKING !!! reset the value back to ' '
        @chessTable[rowIndex][colIndex] = ' '
      end
    end

    return false
  end

  def is_place_valid?(rowIndex,colIndex)

    # Check all columns for the current row
    0.upto(colIndex) { |i| return false if @chessTable[rowIndex][i] == 'Q' }

    # Check diagonal up left
    i = rowIndex
    j = colIndex

    while(i >= 0 && j >= 0)
      return false if @chessTable[i][j] == 'Q'
      i -=1
      j -=1
    end

    # Check diagonal down left
    i = rowIndex
    j = colIndex

    while(i < @numQueens && j >= 0)
      return false if @chessTable[i][j] == 'Q'
      i += 1
      j -= 1
    end

    true # valid move
  end

  def print_solution
    dash = '-'*@numQueens*3
    (0...@numQueens).each do |i|
      print "#{dash}\n"
      (0...@numQueens).each do |j|
        print (@chessTable[i][j] == 'Q') ? " #{@chessTable[i][j]} " : " - "
      end
      puts ''
    end
    print "#{dash}\n"
  end

  def make_2d_array(num)
    Array.new(num){ Array.new(num, ' ') }
  end
end

if __FILE__ == $PROGRAM_NAME
  nqueens = NQueens.new(ARGV[0].to_i)
  nqueens.solve
end
