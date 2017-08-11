require 'deck'

describe 'Deck' do
  subject(:cards) { Deck.new }
  let(:deck) { cards.deck }

  context '#initialize' do
    it "Initialize with a deck of 52 cards" do
      expect(deck.length).to eq(52)
    end

    it "Initializes with a deck of unique cards" do
      (0...deck.length - 1).each do |i|
        (i + 1...deck.length).each do |j|
          card1 = [deck[i].value, deck[i].suit]
          card2 = [deck[j].value, deck[j].suit]
          expect(card1).to_not eq(card2)
        end
      end
    end

    it "Cards should be shuffled" do
      order_deck = []
      Deck::SUITS.each do |suit|
        Deck::VALUES.each do |value|
          order_deck << Card.new(value, suit)
        end
      end

      expect(deck).to_not eq(order_deck)
    end
  end
end
