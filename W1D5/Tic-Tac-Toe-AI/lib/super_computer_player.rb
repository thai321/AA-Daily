require_relative 'tic_tac_toe_node'

class SuperComputerPlayer < ComputerPlayer
  def move(game, mark)
    current_node = TicTacToeNode.new(game.board, mark)
    children = current_node.children

    winning_child = children.find { |child| child.winning_node?(mark)  }
    return winning_child.prev_move_pos if winning_child

    tie_child = children.find { |child| !child.losing_node?(mark) }
    return tie_child.prev_move_pos if tie_child

    raise "I'm going to lose :("
  end
end

if __FILE__ == $PROGRAM_NAME
  puts "Play the brilliant computer!"
  hp = HumanPlayer.new("Jeff")
  cp = SuperComputerPlayer.new

  TicTacToe.new(hp, cp).run
end
