require_relative 'tic_tac_toe'
require 'byebug'

class TicTacToeNode
  attr_reader :board, :next_mover_mark, :prev_move_pos

  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board = board
    @next_mover_mark = next_mover_mark
    @prev_move_pos = prev_move_pos
  end

  def losing_node?(evaluator)
    if @board.over?
      # make sure there is no tie, the current player is not winner
      @board.won? && @board.winner != evaluator
    elsif @next_mover_mark == evaluator
      # current player turn
      # detect every child is a loser
      self.children.all? { |child| child.losing_node?(evaluator) }
    else
      # opponent's turn
      # detect any child is a loser
      self.children.any? { |child| child.losing_node?(evaluator)  }
    end
  end

  def winning_node?(evaluator)
    if @board.over?
      # the game is a winner and current player is the winner
      @board.winner == evaluator
    elsif @next_mover_mark == evaluator
      # current player's turn, true if any child of current is winner
      self.children.any? { |child| child.winning_node?(evaluator) }
    else
      # opponent's turn, true if all children of curren is winner
      self.children.all? { |child| child.winning_node?(evaluator) }
    end
  end

  # This method generates an array of all moves that can be made after
  # the current move.

  def children
    children = []; length = @board.rows.length

    (0...length).each do |x|
      (0...length).each do |y|
        pos = [x, y]

        if board[pos].nil?
          new_board = @board.dup
          new_board[pos] = @next_mover_mark
          next_mark = (@next_mover_mark == :x ? :o : :x)

          child = TicTacToeNode.new(new_board, next_mark, pos)
          children << child
        end
      end
    end

    children
  end

end
