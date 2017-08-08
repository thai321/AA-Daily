require_relative 'board'
require_relative 'card'
require_relative 'HumanPlayer'
require_relative 'AIPlayer'

require 'byebug'
class Game
  def initialize(*players, board)
    @current_player = players.first
    @computer = players.find { |player| (player.is_a? AIPlayer) }
    @computer.learn_size(Board::GRIDSIZE) if !@computer.nil?
    @players = players
    @board = board
    @previous_guess = nil
  end

  def play
    @board.render
    single_round until over?
    puts "Congrats..."
  end



  def next_player!
    @players.rotate!
    @current_player = @players.first
  end

  def single_round
    still = true
    while still
      input = @current_player.guess # guess pos input
      still = make_guess(input)
      @board.render
      display_status
      puts "-------------"; puts ""
    end
    next_player!
  end

  def display_status
    @players.each { |player| puts "#{player}: #{player.score}" }
  end

  def over?
    @board.won?
  end

  # def prompt
  #   puts 'Please enter a position in this format (1, 1).'
  # end

  def make_guess(pos) #
    # byebug
    puts "#{pos}"
    current_value = @board.reveal(pos)
    @computer.memorize_card(pos, current_value) unless @computer.nil?
    if @previous_guess.nil?
      @computer.current_value = current_value if @current_player.is_a? AIPlayer
      @previous_guess = pos
    else
      if current_value != @board.reveal(@previous_guess)
        display_toggle
        @board[@previous_guess].hide
        @board[pos].hide
        @previous_guess = nil
        return false
      else # there is a match
        @current_player.score += 1
        @computer.memorize_match_card(@previous_guess, pos) unless @computer.nil?
      end
      # Refresh the current game for a new first guess
      @previous_guess = nil
    end
    true
  end

  def display_toggle
    @board.render
    sleep(3)
    system("clear")
  end

end


if __FILE__ == $0
  player1 = HumanPlayer.new("Thai")
  player2 = HumanPlayer.new("Chris")
  player3 = HumanPlayer.new("Calvin")
  computer = AIPlayer.new("Ruby")

  b = Board.new
  a = Game.new(player1, player2, player3, computer, b)
  a.play
end
