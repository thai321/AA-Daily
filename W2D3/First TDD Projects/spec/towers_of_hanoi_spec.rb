require 'towers_of_hanoi'

describe 'Towers of Hanoi' do
  subject(:game) { Game.new }

  context '#intialize' do
    it 'initialize tower has an array\'s length of 3' do
      expect(game.tower.length).to eq(3)
    end

    it 'First pile has length of 3 and contains all the discs in order ' do
      expect(game.tower[0].length).to eq(3)
      expect(game.tower[0]).to eq([3, 2, 1])
    end
  end
end
