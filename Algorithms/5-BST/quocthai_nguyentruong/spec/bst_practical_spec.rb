require 'rspec'
require 'bst_practical'

describe 'BST Practical Question' do
  let(:prefilled_bst) do
    bst = BinarySearchTree.new
    [5, 3, 7, 1, 4, 9, 0, 2, 1.5, 10].each do |el|
      bst.insert(el)
    end

    bst
  end

  let(:balanced_bst) do
    bst = BinarySearchTree.new
    [14, 4, 16, 1, 10, 20].each do |el|
      bst.insert(el)
    end

    bst
  end

  it "returns the kth largest node" do
    k = 7
    k_node = prefilled_bst.root.left.left.right
    # the above node is pointing to the node with value 2

    expect(kth_largest(prefilled_bst.root, k)).to be(k_node)


    n = 2 
    n_node = balanced_bst.root.right
    # the above node is pointing to the node with value 16

    expect(kth_largest(balanced_bst.root, n)).to be(n_node)
  end
end
