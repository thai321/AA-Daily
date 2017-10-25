require 'rspec'
require 'dynamic_programming'
require 'rspec-benchmark'

describe 'Frog Hops Bottom Up' do
  include RSpec::Benchmark::Matchers
  let(:dp) { DynamicProgramming.new() }

  it 'handles a base case' do
    expect(dp.frog_hops_bottom_up(1)).to eq([[1]])
    expect(dp.frog_hops_bottom_up(2).sort).to eq([[1, 1], [2]])
  end

  it 'handles recursive cases' do
    expect(dp.frog_hops_bottom_up(4).sort).to eq([[1, 1, 1, 1], [1, 1, 2], [1, 2, 1], [2, 1, 1], [2, 2], [1, 3], [3, 1]].sort)
    expect(dp.frog_hops_bottom_up(10).length).to eq(274)
    expect(dp.frog_hops_bottom_up(10)).to include([1, 3, 3, 3])
  end

  # it 'runs in non-exponential time' do
  #   expect { dp.frog_hops_bottom_up(20) }.to perform_under(1000).ms
  # end
end

describe 'Frog Hops Top Down' do
  include RSpec::Benchmark::Matchers
  let(:dp) { DynamicProgramming.new() }

  it 'should call helper method' do
    expect(dp).to receive(:frog_hops_top_down_helper)
    dp.frog_hops_top_down(4)
  end

  it 'should call helper method recursively' do
    expect(dp).to receive(:frog_hops_top_down_helper).at_least(4).times.and_call_original
    dp.frog_hops_top_down_helper(4)
  end

  it 'handles a base case' do
    expect(dp.frog_hops_top_down(1)).to eq([[1]])
    expect(dp.frog_hops_top_down(2).sort).to eq([[1, 1], [2]])
  end

  it 'handles recursive cases' do
    expect(dp.frog_hops_top_down(4).sort).to eq([[1, 1, 1, 1], [1, 1, 2], [1, 2, 1], [2, 1, 1], [2, 2], [1, 3], [3, 1]].sort)
    expect(dp.frog_hops_top_down(10).length).to eq(274)
    expect(dp.frog_hops_top_down(10)).to include([1, 3, 3, 3])
  end

  # it 'runs in non-exponential time' do
  #   expect { dp.frog_hops_top_down(20) }.to perform_under(1000).ms
  # end
end
