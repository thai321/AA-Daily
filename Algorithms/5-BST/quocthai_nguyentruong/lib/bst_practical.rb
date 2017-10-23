require "binary_search_tree"

def kth_largest(tree_node, k)
  k_value = tree_node.tree.in_order_traversal(tree_node)[-k]
  tree_node.tree.find(k_value)
end
