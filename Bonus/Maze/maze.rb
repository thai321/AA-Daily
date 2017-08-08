class Map
  attr_reader :start, :goal, :map
  def initialize(file)
    @map = make_map(file)
    @start = find_point('S')
    @goal = find_point('E')
  end

  def make_map(file)
    File.readlines(file).map(&:chomp)
  end

  def pos(x,y)
    @map[x][y]
  end

  def display
    (0...@map.size).each do |i|
      (0...@map[0].size).each do |j|
        print "#{ pos(i,j) } "
      end
      puts "\n"
    end
  end

  def find_point(char)
    (0...@map.size).each do |i|
      (0...@map[0].size).each do |j|
        return [i,j] if pos(i,j) == char
      end
    end
  end

end

class SolveMaze
  MOVES = [ [0, -1], [0, 1], [-1, 0], [1, 0] ]
  attr_accessor :map, :solution

  def initialize(map, start, goal)
    @map = map
    @solution = map.map
    @start = start
    @goal = goal
    @visited = boolean_2d_array
  end

  def solve
    if dfs(@start[0],@start[1])
      puts "There is a solution"
    else
      puts "There is No way out"
    end
  end

  def dfs(x,y)
    return true if(@map.map[x][y] == 'E')

    @visited[x][y] = true
    @solution[x][y] = 'X' if @map.map[x][y] != '*'

    if(is_valid_move?(x, y - 1))
      if(dfs(x, y - 1))
        # @solution[x][y - 1] = 'X'
        return true
      end
      # @solution[x][y - 1] = ' '
    end

    if(is_valid_move?(x, y + 1))
      if(dfs(x, y + 1))
        # @solution[x][y + 1] = 'X'
        return true
      end
      # @solution[x][y + 1] = ' '
    end


    if(is_valid_move?(x - 1, y))
      if(dfs(x - 1, y))
        # @solution[x - 1][y] = 'X'
        return true
      end
      # @solution[x - 1][y] = ' '
    end

    if(is_valid_move?(x + 1, y))
      if(dfs(x + 1, y))
        # @solution[x + 1][y] = 'X'
        return true
      end
      # @solution[x + 1][y] = ' '
    end


    @solution[x][y] = ' '

    return false
  end

  def is_valid_move?(x,y)
    # p "hello"
    xSize = @map.map.size - 1
    ySize = @map.map[0].size - 1

    xValid = (x >= 0 && x <= xSize)
    yValid = (y >= 0 && y <= ySize)

    xValid && yValid && @map.map[x][y] != '*' && !is_visited?(x,y)
  end

  def is_visited?(x,y)
    @visited[x][y] == true
  end

  def print_solution
    (0...@solution.size).each do |i|
      (0...@solution[0].size).each do |j|
        print "#{ @solution[i][j] } "
      end
      puts ''
    end

  end


  def boolean_2d_array
    Array.new(@map.map.size) { Array.new(@map.map[0].size, false) }
  end

end


if __FILE__ == $PROGRAM_NAME
 file = 'mazes/maze1.txt'
 map = Map.new(file)
 # p map.pos(1,1) == ' '
 p map.display
 # p map.map[3][7]
 p map.start
 p map.goal

 a = SolveMaze.new(map, map.start, map.goal)
 a.solve
 a.print_solution
end
