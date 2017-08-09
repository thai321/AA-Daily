require_relative 'card'

class Deck
  attr_accessor :deck

  SUITS = %w[♠ ♥ ♦ ♣].freeze
  VALUES = [*"2".."10"] + %w[J Q K A]

  def initialize
    @deck = create_deck
    shuffle_cards
  end

  def create_deck
    deck = []
    SUITS.each do |suit|
      VALUES.each do |value|
        deck << Card.new(value, suit)
      end
    end

    deck
  end

  def shuffle_cards
    @deck.shuffle!
  end
end
