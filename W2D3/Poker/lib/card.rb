require_relative 'deck'

class Card
  include Comparable

  attr_reader :value, :suit

  def initialize(value, suit)
    @value = value
    @suit = suit
  end

  def <=>(other_card)
    Deck::VALUES.index(@value) <=> Deck::VALUES.index(other_card.value)
  end
end
