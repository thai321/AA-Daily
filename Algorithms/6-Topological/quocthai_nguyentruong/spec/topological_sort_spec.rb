require 'rspec'
require 'topological_sort'

describe 'TopologicalSort' do
  let(:v1) { Vertex.new("Wash Markov") }
  let(:v2) { Vertex.new("Feed Markov") }
  let(:v3) { Vertex.new("Dry Markov") }
  let(:v4) { Vertex.new("Brush Markov") }
  let(:v5) { Vertex.new("Cuddle Markov") }
  let(:v6) { Vertex.new("Walk Markov") }
  let(:v7) { Vertex.new("Teach Markov") }
  let(:v8) { Vertex.new("Worship Markov") }
  let(:vertices) { [] }

  before(:each) do
    vertices.push(v1, v2, v3, v4, v5, v6, v7, v8)
  end

  it "sorts the vertices" do
    solutions = [
      [v1.value, v2.value, v3.value, v4.value, v5.value, v6.value, v7.value, v8.value],
      [v1.value, v2.value, v3.value, v5.value, v4.value, v6.value, v7.value, v8.value],
      [v1.value, v3.value, v2.value, v4.value, v5.value, v6.value, v7.value, v8.value],
      [v1.value, v3.value, v2.value, v5.value, v4.value, v6.value, v7.value, v8.value]
    ]

    1.times do
      Edge.new(v1, v2)
      Edge.new(v1, v3)
      Edge.new(v2, v4)
      Edge.new(v3, v4)
      Edge.new(v2, v5)
      Edge.new(v4, v6)
      Edge.new(v5, v6)
      Edge.new(v6, v7)
      Edge.new(v7, v8)
      expect(solutions).to include(topological_sort(vertices.shuffle).map{ |vert| vert.value})
    end
  end

  it "returns [] for a cyclic or unconnected graph" do

    1.times do
      Edge.new(v1, v2)
      Edge.new(v1, v3)
      Edge.new(v2, v4)
      Edge.new(v3, v4)
      Edge.new(v2, v5)
      Edge.new(v4, v6)
      Edge.new(v5, v6)
      Edge.new(v6, v7)
      Edge.new(v7, v8)
      Edge.new(v8, v2)
      expect(topological_sort(vertices.shuffle).map{ |el| el.value }).to eq([])
    end
  end
end
