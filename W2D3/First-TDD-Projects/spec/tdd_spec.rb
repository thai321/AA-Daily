require 'tdd'
require 'byebug'

describe "TDD" do
  context "#my_uniq" do
    let(:arr) { [1, 2, 3, 3, 2] }

    it "Removes duplicates elements from an array in order" do
      expect(my_uniq(arr)).to eq([1, 2, 3])
    end

  end

  context "#two_sum" do
    let(:arr) { [-1, 0, 2, -2, 1] }
    let(:result) { arr.two_sum }

    it "Returns pairs that sum to zero" do
      result.each do |x, y|
        expect(arr[x] + arr[y]).to eq(0)
      end
    end

    it "Pairs are in order" do
      result.each do |x, y|
        expect(x).to be < y
      end
      (0...result.length - 1).each do |i|
        expect(result[i][0]).to be < result[i + 1][0]
      end
    end

    it "Each subarray has a length of two" do
      expect(result.all? { |pair| pair.length == 2 }).to be true
    end
  end

  context '#my_tranpose' do
    let(:rows) { [[0, 1, 2], [3, 4, 5], [6, 7, 8]] }
    let(:cols) { my_tranpose(rows) }

    it "Correctly return columns" do
      expect(cols).to eq([[0, 3, 6], [1, 4, 7], [2, 5, 8]])
    end

    it "Return the same square length" do
      expect(cols.length).to eq(rows.length)
      expect(cols[0].length).to eq(rows[0].length)
    end
  end

  context '#stock_picker' do
    let(:stock) { [21.30, 19.15, 23.15, 16.82, 22.45, 22.30] }
    let(:result) { stock_picker(stock) }

    it "Should not sell stock before buying" do
      expect(result[0]).to be < result[1]
    end

    it "Returns most profitable pair of days" do
      expect(result).to eq([3, 4])
    end

  end
end
