# Given an Array of tuples, where tuple[0] represents a package id,
# and tuple[1] represents its dependency, determine the order in which
# the packages should be installed. Only packages that have dependencies
# will be listed, but all packages from 1..max_id exist.

# N.B. this is how `npm` works.

# Import any files you need to
require_relative "graph"
require_relative "topological_sort"


def install_order(arr)
  max_id = 0
  order = {}

  arr.each do |tuple|
    if order[tuple[0]].nil?
      order[tuple[0]] = Vertex.new(tuple[0])
    end
    if order[tuple[1]].nil?
      order[tuple[1]] = Vertex.new(tuple[1])
    end

    Edge.new(order[tuple[1]], order[tuple[0]])
    max_id = tuple.max if tuple.max > max_id
  end

  indepencies = (1..max_id).select { |id| order[id].nil? }

  topological_sort(order.values).map { |v| v.value } + indepencies
end
