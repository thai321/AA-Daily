class DynamicProgramming

  def initialize
    @blair_cache = { 1 => 1, 2 => 2}
    @frog_cache = [[], [[1]], [[1,1],[2]], [[1,1,1],[1,2],[2,1],[3]]]
    @super_frog_cache = [[], [[1]]]
  end

=begin
1 1
2 3
3 5
4 7
...
n nth odd

1 -> 1  = 1
2 -> 1 + 2  = 3
3 -> 1 + 2 + 2 = 5
4 -> 1 + 2 + 2 + 2 = 7
...
n -> 1 + 2(n-1) = 1 + 2n - 2 = 2n -1
=end

  def blair_nums(n)
    return @blair_cache[n] if @blair_cache[n]

    @blair_cache[n] = blair_nums(n - 1) + blair_nums(n - 2) + (2*(n - 1) - 1)

    @blair_cache[n]
  end

  def frog_hops_bottom_up(n)
     frog_cache_builder(n)
  end

  def frog_cache_builder(n)
    return @frog_cache[n] if @frog_cache[n]

    4.upto(n) do |i|
      result = []

      [1,2,3].each do |step|
        @frog_cache[i - step].each do |steps|
        result << steps + [step]
       end
     end

     @frog_cache[i] = result
    end

   @frog_cache[n]
  end

  def frog_hops_top_down(n)
    frog_hops_top_down_helper(n)
  end

  def frog_hops_top_down_helper(n)
    return @frog_cache[n] if @frog_cache[n]

    result = []
    [1,2,3].each do |step|
      frog_hops_top_down_helper(n - step).each do |steps|
        result << steps + [step]
      end
    end

    @frog_cache[n] = result
    result
  end

  def super_frog_hops(n, k)
    return [[]] if n == 0
    return [[1]] if n == 1

    result = []

    super_frog_hops(n - 1, k).each do |steps|
      result << steps + [1]
      result << steps[0...-1] + [steps.last + 1] if steps.last < k
    end

    result
  end

  # Time Complexity: O(n*w)
  def knapsack(weights, values, capacity)
    items = weights.length
    return 0 if items == 0 || capacity == 0

    table = Array.new(items)

    0.upto(capacity) do |w|
      table[w] = []
      0.upto(items - 1) do |i|
        table[w][i] = 0 if w == 0
        if i == 0
          table[w][i] =  w < weights[0] ? 0 : values[i]
        else
          notTakingItem = table[w][i - 1]
          takingItem = 0

          if weights[i] <= w
            takingItem = table[w - weights[i]][i - 1] + values[i]
          end

          table[w][i] = [notTakingItem, takingItem].max
        end
      end
    end

    table[capacity][items - 1]
  end

  # Helper method for bottom-up implementation
  def knapsack_table(weights, values, capacity)
  end

  def maze_solver(maze, start_pos, end_pos)
  end
end
