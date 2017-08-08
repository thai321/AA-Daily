class AIPlayer
  attr_reader :name , :size
  attr_accessor :score, :known_cards, :matched_cards, :next_guess, :current_value

  def initialize(name)
    @name = name
    @score = 0
    @matched_cards = []
    @known_cards = Hash.new
    @matched_cards = []
    @current_guess = nil
    @current_value = nil
    @next_guess = nil
  end

  def learn_size(size)
    @size = size
  end

  def guess
    puts "#{self}\'s turn"


    # Second time flip if 2 match known_cards
    if !@next_guess.nil?
      temp = @next_guess
      @next_guess = nil
      @current_value = nil
      @matched_cards << temp
      return temp
    end

    if !@current_value.nil?
      a =  @known_cards.find { |k,v| v == @current_value && k != @current_guess }
      @current_value = nil
      return a.first if !a.nil?
    end

    if @known_cards.empty? || @known_cards.size == 1
      @current_guess = random_guess
      @current_value = nil
      return random_guess
    end

    # First time flip , return only if 2 match known card
    @known_cards.each do |k1,v1|
      @known_cards.each do |k2,v2|
        if k1 != k2 && v1 == v2 && !@matched_cards.include?(k1)
          @next_guess = k2
          @matched_cards << k1
          @current_value = nil
          return k1
        end
      end
    end

    @current_value = nil
    @current_guess = random_guess

  end

  def random_guess
    x = rand(size)
    y = rand(size)
    random_guess if @matched_cards.include?([x,y]) && @known_cards.include?([x,y])
    [x,y]
  end

  def memorize_card(pos,value)
    if !@known_cards[pos]
      @known_cards[pos] = value
    end
  end

  def memorize_match_card(pos1, pos2) # [x,y]
    @matched_cards << pos1
    @matched_cards << pos2
  end

  def prompt
    puts "#{self}'s turn'"
    puts 'Please enter a position in this format (1, 1).'
  end

  def to_s
    @name
  end

end
