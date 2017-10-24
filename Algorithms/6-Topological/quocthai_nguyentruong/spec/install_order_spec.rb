require 'graph'
require 'topological_sort'
require 'install_order'

describe '#install_order' do

  it 'fills in nodes with no dependencies' do
    arr = [[3, 1], [2, 1], [6, 5], [3, 6], [3, 2], [4, 3], [9, 1]]
    result = install_order(arr)
    expect(result.index(8)).not_to be_nil
    expect(result.index(7)).not_to be_nil
  end

  it 'returns the correct order' do
    arr = [[3, 1], [2, 1], [6, 5], [3, 6], [3, 2], [4, 3], [9, 1]]
    result = install_order(arr)
    expect(result.index(3)).to be > result.index(1)
    expect(result.index(2)).to be > result.index(1)
    expect(result.index(6)).to be > result.index(5)
    expect(result.index(3)).to be > result.index(6)
    expect(result.index(3)).to be > result.index(2)
    expect(result.index(4)).to be > result.index(3)
    expect(result.index(9)).to be > result.index(1)
  end

end
