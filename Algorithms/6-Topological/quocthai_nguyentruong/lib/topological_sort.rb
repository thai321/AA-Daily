require_relative 'graph'

# Implementing topological sort using both Khan's and Tarian's algorithms

def topological_sort(vertices)
  result = []

  queue = vertices.select { |vertex| vertex.in_edges.empty? }

  until queue.empty?
    current = queue.shift
    result << current

    current.out_edges.dup.each do |edge|
      queue << edge.to_vertex if edge.to_vertex.in_edges.length == 1
      edge.destroy!
    end
  end

  return (result.length == vertices.length) ? result : []
end
