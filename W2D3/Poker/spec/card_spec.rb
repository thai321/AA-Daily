require 'card'

describe 'Card' do
  subject(:card) { Card.new("2", "♥") }

  context '#initialize' do
    it "Should initialize a card value" do
      expect(card.value).to eq("2")
    end

    it "Should initialize a card suit" do
      expect(card.suit).to eq("♥")
    end
  end

  context 'comparable' do
    let(:card2) { Card.new("J", "♥") }

    it "Should compare card value with another's" do
      expect(card <=> card2).to eq(-1)
    end
  end
end
