require 'byebug'

class PolyTreeNode
  attr_accessor :value, :parent, :children
  def initialize(value)
    @value = value
    @parent = nil
    @children = []
  end

  def parent=(node)
    # byebug
    @parent = node
    node.children += @children
  end
end
