require 'dynamic_programming'
require 'rspec'

describe 'Maze traversal' do
  let(:maze1) { [['X', 'X', 'X', 'X'],
                 ['X', 'S', ' ', 'X'],
                 ['X', 'X', 'F', 'X']] }
  let(:maze2) { [['X', 'X', 'X', ' ', 'X', 'X', 'F', 'X'],
                 ['X', 'S', 'X', ' ', 'X', 'X', ' ', 'X'],
                 ['X', ' ', ' ', ' ', ' ', ' ', ' ', ' '],
                 ['X', 'X', 'X', ' ', 'X', 'X', ' ', 'X'],
                 ['X', ' ', ' ', ' ', ' ', ' ', ' ', 'X'],
                 ['X', 'X', 'X', 'X', 'X', 'X', 'X', 'X']] }

  let(:dp) { DynamicProgramming.new() }

  it 'handles a small maze' do
    expect(dp.maze_solver(maze1, [1, 1], [0, 6])).to eq([[1, 1], [1, 2], [2, 2]])
  end

  it 'chooses the optimal solution among many' do
    maze_soln = [[1, 1], [2, 1], [2, 2], [2, 3], [2, 4], [2, 5], [2, 6], [1, 6], [0, 6]]
    expect(dp.maze_solver(maze2, [1, 1], [0, 6])).to eq(maze_soln)
  end
end
