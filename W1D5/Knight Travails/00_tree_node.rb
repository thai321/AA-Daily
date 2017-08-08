require 'byebug'

class PolyTreeNode
  attr_accessor :value, :parent, :children
  def initialize(value)
    @value = value
    @parent = nil
    @children = []
  end

  def parent=(new_node)
    if !new_node.nil? && !new_node.parent.nil?
      new_node.parent.children.delete(self)
    end

    if !new_node.nil?
      new_node.children << self if !new_node.children.include?(self)
    end

    @parent = new_node

  end

  def add_child(child)
    child.parent = self
    @children << child if !@children.include?(child)
  end

  def remove_child(child)
    raise "Error: Not a child" if !@children.include?(child)
    child.parent = nil
  end

  def dfs(target_value)
    return self if @value == target_value

    @children.each do |child|
      node = child.dfs(target_value)
      return node if node
    end
    nil
  end

  def bfs(target_value)
    queue = [self]

    until queue.empty?
      node = queue.shift
      return node if node.value == target_value

      queue.concat(node.children)
    end
    nil
  end
end
