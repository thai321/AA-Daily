require 'rspec'
require 'dynamic_programming'

describe 'Knapsack' do
  let(:dp) { DynamicProgramming.new() }
  let (:weights1) { [23, 31, 29, 44, 53, 38, 63, 85, 89, 82 ]}
  let(:values1) { [ 92, 57, 49, 68, 60, 43, 67, 84, 87, 72 ]}
  let(:weights2) {  [12, 7, 11, 8, 9 ] }
  let(:values2) { [ 24, 13, 23, 15, 16] }

  it 'handles trivial cases' do
    expect(dp.knapsack(weights1, values1, 0)).to equal(0)
    expect(dp.knapsack(weights1, values1, 23)).to equal(92)
  end

  it 'handles recursive cases' do
    expect(dp.knapsack(weights1, values1, 165)).to equal(309)
    expect(dp.knapsack(weights2, values2, 26)).to equal(51)
  end
end
