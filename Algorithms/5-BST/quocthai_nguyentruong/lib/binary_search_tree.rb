# There are many ways to implement these methods, feel free to add arguments
# to methods as you see fit, or to create helper methods.

require "bst_node"
require "byebug"

class BinarySearchTree
  attr_accessor :root

  def initialize
    @root = nil
  end

  def insert(value)
    @root = @root.nil? ? BSTNode.new(value) : put(@root, value)
    @root.tree = self
  end

  def find(value, tree_node = @root)
    return nil if tree_node.nil?

    return tree_node if tree_node.value == value

    return (value < tree_node.value) ?
            find(value, tree_node.left)
          : find(value, tree_node.right)

  end

  def delete(value)
    if @root.value == value
      @root = nil
    else
      delete!(@root, value)
    end
  end

  def depth(tree_node = @root)
    return -1 if tree_node.nil?

    depth_left = depth(tree_node.left) + 1
    depth_right = depth(tree_node.right) + 1

    [depth_left, depth_right].max
  end

  def is_balanced?(tree_node = @root)
    return true if depth(tree_node) <= 1
    diff = (depth(tree_node.left) - depth(tree_node.right)).abs

    diff <= 1 && is_balanced?(tree_node.left) && is_balanced?(tree_node.right)
  end

  def in_order_traversal(tree_node = @root, arr = [])
    in_order_traversal(tree_node.left, arr) if tree_node.left
    arr << tree_node.value
    in_order_traversal(tree_node.right, arr) if tree_node.right
    arr
  end


  # helper method for #delete:
  def maximum(tree_node = @root)
    return tree_node.right.nil? ?
            tree_node
          : maximum(tree_node.right)
  end

  private
  # optional helper methods go here:

  def put(node, value)
    return BSTNode.new(value) if node.nil?

    if value <= node.value
      node.left = put(node.left, value)
    else
      node.right = put(node.right, value)
    end

    node
  end

  def delete!(node, value)
    return remove_node(node) if node.value == value

    if value <= node.value
      node.left = delete!(node.left, value)
    else
      node.right = delete!(node.right, value)
    end
  end

  def remove_node(node)
    if node.isLeaf?
      node = nil
    elsif node.hasBothChildren?
      successor = find_successor(node)
      successor.left = node.left
      successor.right = node.right
      node = successor
    else
      node = node.hasLeftChild? ? node.left : node.right
    end

    node
  end

  def find_successor(node)
    successor = maximum(node.left)
    if successor.left && node.left.right
      parent = node.left
      maximum_node = maximum(node.left.right)
      parent.right = maximum_node.left
    end

    successor
  end

end
