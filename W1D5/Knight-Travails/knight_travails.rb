require_relative '00_tree_node'
require 'byebug'

class KnightPathFinder
  attr_accessor :visited_positions, :root
  attr_reader :source

  BOARD_SIZE = 8
  MOVES = [
    [2, 1],
    [2, -1],
    [1, 2],
    [1, -2],
    [-2, 1],
    [-2, -1],
    [-1, 2],
    [-1, -2]
  ]

  def initialize(source)
    @source = source
    @visited_positions = [source]
    build_move_tree
  end

  def new_move_positions(pos)
    moves = valid_moves(pos)
    moves.select! { |visit_pos| !@visited_positions.include?(visit_pos) }
    @visited_positions.concat(moves)
    moves
  end

  def find_path(end_pos)
    target_node = @root.dfs(end_pos)
    trace_path_back(target_node)
  end

  def trace_path_back(target_node)
    path = []
    current_node = target_node

    until current_node.nil?
      path.unshift(current_node.value)
      current_node = current_node.parent
    end
    path
  end

  def build_move_tree
    @root = PolyTreeNode.new(source)
    queue = [root]
    until queue.empty?
      current_node = queue.shift
      current_pos = current_node.value
      puts current_pos
      new_move_positions(current_pos).each do |pos|
        child = PolyTreeNode.new(pos)
        current_node.add_child(child)
        queue << child
      end
    end
  end

  def valid_moves(pos)
    moves = []

    x, y = pos
    MOVES.each do |i, j|
      current_pos = [x + i, y + j]
      x_valid = current_pos[0] >= 0 && current_pos[0] < BOARD_SIZE
      y_valid = current_pos[1] >= 0 && current_pos[1] < BOARD_SIZE
      if x_valid && y_valid
        moves << current_pos
      end
    end
    moves
  end
end

if __FILE__ == $PROGRAM_NAME
  knigh_path = KnightPathFinder.new([0, 0])

  # [[0, 0], [2, 1], [4, 2], [6, 3], [5, 5], [7, 6]]
  p knigh_path.find_path([7, 6])

  # [[0, 0], [2, 1], [4, 2], [5, 4], [6, 2]]
  p knigh_path.find_path([6, 2])
end
