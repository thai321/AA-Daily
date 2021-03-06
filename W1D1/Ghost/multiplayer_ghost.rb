require 'byebug'
require 'set'

class Game
  attr_accessor :players, :current_player, :previous_player, :fragment
  attr_reader :dictionary
  MAX_LOSS = 2

  def initialize(players, file)
    @players = players
    @current_player, @previous_player = players.first
    @dictionary = make_dictionary(file)
    @fragment = ''
    set_up_losses
  end

  def play
    full_game until game_over?
    puts "#{winner} won the game!"
  end

  private

  def set_up_losses
    @losses = Hash.new(0)
    @players.each { |player| @losses[player] = 0 }
  end

  def make_dictionary(file)
    File.readlines(file).map(&:chomp).to_set
  end

  def full_game
    single_game
    display_status
    reset
  end

  def game_over?
    winner_count = @losses.values.count { |losses| losses < MAX_LOSS }
    winner_count == 1
  end

  def winner
    winner = @losses.find { |player, value| value < MAX_LOSS }
    winner.first
  end

  # Single game
  def single_game
    play_round until @dictionary.include?(@fragment)
    @losses[@previous_player] += 1
  end

  def reset
    @fragment = ''
  end

  def display_status
    @losses.each do |player, count|
      puts "#{player}: #{'GHOST'[0,count]}"
    end
  end

  def play_round
    @previous_player = @current_player
    puts "\n#{@current_player}'s turn:"
    take_turn(@current_player)
    p @fragment
    next_player!
  end

  def next_player!
    @players.rotate!
    @players.rotate! until (@losses[@players.first] < MAX_LOSS)
    @current_player = @players.first
  end

  def take_turn(player)
    letter = player.guess

    if valid_play?(letter)
      @fragment += letter
    else
      puts "Invalid play, guess a different letter."
      take_turn(player)
    end
  end

  def valid_play?(letter)
    @dictionary.any? { |word| word.start_with?(@fragment + letter) }
  end
end

class Player
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def guess
    puts "Guess a letter:"
    letter = gets.chomp
    letter
  end

  def to_s
    @name
  end
end

if __FILE__ == $PROGRAM_NAME
 #file = 'dictionary.txt'
  player_1 = Player.new("Thai")
  player_2 = Player.new("Paolo")
  player_3 = Player.new("MOSH")
  players = [player_1, player_2, player_3]

  first_game = Game.new(players, "dictionary.txt")

  first_game.play


end
