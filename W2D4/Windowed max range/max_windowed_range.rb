require_relative 'min_max_stack_queue'
require 'byebug'

# Naive solution
# O(n * m)

def max_windowed_range_naive(arr, w) # w: window size
  length = arr.length - w
  best_range = arr.slice(0, w).max - arr.slice(0, w).min

  (1..length).each do |i|
    range_arr = arr.slice(i, w)
    current_range = range_arr.max - range_arr.min
    best_range = [best_range, current_range].max
  end

  best_range
end


p max_windowed_range_naive([1, 0, 2, 5, 4, 8], 2) == 4 # 4, 8
p max_windowed_range_naive([1, 0, 2, 5, 4, 8], 3) == 5 # 0, 2, 5
p max_windowed_range_naive([1, 0, 2, 5, 4, 8], 4) == 6 # 2, 5, 4, 8
p max_windowed_range_naive([1, 3, 2, 5, 4, 8], 5) == 6 # 3, 2, 5, 4, 8


# Naive solution
# O(n)

def max_windowed_range_optimized(arr, w) # w: window size
  queue = MinMaxStackQueue.new
  best_range = -100 #arr.slice(0, w).max - arr.slice(0, w).min

  arr.slice(0, w).each {  |el| queue.enqueue(el) }

  arr[w...arr.length].each_with_index do |el, i|

    byebug
    best_range = [best_range,  queue.max - queue.min].max

    queue.dequeue
    queue.enqueue(el)

    # # byebug
    # queue.dequeue if queue.size == w
    #
    # if queue.size == w
    #   best_range = [best_range, queue.max - queue.min].max
    # end
  end

  best_range
end


p max_windowed_range_optimized([1, 0, 2, 5, 4, 8], 2) # 4  # 4, 8
# p max_windowed_range_optimized([1, 0, 2, 5, 4, 8], 3) #== 5 # 0, 2, 5
# p max_windowed_range_optimized([1, 0, 2, 5, 4, 8], 4) #== 6 # 2, 5, 4, 8
# p max_windowed_range_optimized([1, 3, 2, 5, 4, 8], 5) #== 6 # 3, 2, 5, 4, 8
