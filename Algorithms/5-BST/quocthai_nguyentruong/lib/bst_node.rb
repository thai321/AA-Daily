class BSTNode
  attr_accessor :left, :right, :tree
  attr_reader :value

  def initialize(val)
    @value = val
    @left, @right = nil
  end

  def isLeaf?
    @left.nil? && @right.nil?
  end

  def hasBothChildren?
    @left && @right
  end

  def hasLeftChild?
    @left
  end

  def hasRightChild?
    @right
  end
end
