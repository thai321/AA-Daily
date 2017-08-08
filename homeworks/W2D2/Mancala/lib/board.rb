require 'byebug'

class Board
  attr_accessor :cups

  def initialize(name1, name2)
    @name1 = name1
    @name2 = name2
    @cups = Array.new(14) { Array.new }
    place_stones
  end

  def place_stones
    # helper method to #initialize every non-store cup with four stones each
    (0..5).each { |i| @cups[i] = [:stone] * 4 }
    (7..12).each { |i| @cups[i] = [:stone] * 4 }
  end

  def valid_move?(start_pos)
    raise "Invalid starting cup" if !start_pos.between?(0,12)
    if start_pos == 0 || start_pos == 13
      raise "Invalid starting cup"
    end
  end

  def make_move(start_pos, current_player_name)
    stones = @cups[start_pos]
    @cups[start_pos] = []

    index = start_pos
    until stones.empty?
      index += 1
      index = 0 if index == 14

      if index == 6
        @cups[index] << stones.pop if current_player_name == @name1
      elsif index == 13
        @cups[index] << stones.pop if current_player_name == @name2
      else
        @cups[index] << stones.pop
      end
    end

    render
    next_turn(index)
  end

  def next_turn(ending_cup_idx)
    # helper method to determine what #make_move returns

    # when the turn ended on the current player's points cup
    return :prompt if (ending_cup_idx == 6) || (ending_cup_idx == 13)

    # when the turn ended on an empty cup
    return :switch if @cups[ending_cup_idx].length == 1

    # when the turn ended on a cup with stones already in it
    # returns the cup's array index
    ending_cup_idx
  end

  def render
    print "      #{@cups[7..12].reverse.map { |cup| cup.count }}      \n"
    puts "#{@cups[13].count} -------------------------- #{@cups[6].count}"
    print "      #{@cups.take(6).map { |cup| cup.count }}      \n"
    puts ""
    puts ""
  end

  def one_side_empty?
    @cups[0..5].all? { |cup| cup.empty? } || \
    @cups[7..12].all? { |cup| cup.empty? }
  end

  def winner
    return :draw if @cups[6].length == @cups[13].length
    (@cups[6].length > @cups[13].length) ? @name1 : @name2
  end
end
