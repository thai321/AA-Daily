require 'set'
require 'byebug'
# Brute Force
# O(N^2) time
# O(N^2) space
def bad_two_sum?(arr, target)

  arr.each_with_index do |el1, i|
    arr.each_with_index do |el2, j|
      next if i == j
      return true if (el1 + el2) == target
    end
  end

  false
end

arr = [0, 1, 5, 7]
p bad_two_sum?(arr, 6) # => should be true
p bad_two_sum?(arr, 10) # => should be false

# ----------------------------------------------------

# Sorting
# O(Nlog(N)) time
# O(N) space

def okay_two_sum?(arr, target)
  sort_arr = arr.sort

  i = 0
  j = sort_arr.length - 1

  while i != j
    return true if sort_arr[i] + sort_arr[j] == target

    if sort_arr[j] > target
      j -= 1
    else
      i += 1
    end
  end
  false
end

arr = [0, 1, 5, 7]
p okay_two_sum?(arr, 6) # => should be true
p okay_two_sum?(arr, 10) # => should be false


# ----------------------------------------------------
# Set
# Time O(N)
# Space O(N)
def two_sum?(arr, target)


  visited = Set.new

  arr.each do |el|
    missing_val = target - el
    return true if visited.include?(missing_val)
    visited.add(el) if !visited.include?(el)
  end
  false
end

arr = [0, 1, 5, 7]
p two_sum?(arr, 6) # => should be true
# p two_sum?(arr, 10) # => should be false

def windowed_max_range(arr, window)
  current_max_range = 0
  i = 0

  while i <= arr.length - window

    range = arr[i...i + window].max - arr[i...i + window].min
    current_max_range = range if range > current_max_range
    i += 1
  end
  current_max_range
end

p windowed_max_range([1, 0, 2, 5, 4, 8], 2) == 4 # 4, 8
p windowed_max_range([1, 0, 2, 5, 4, 8], 3) == 5 # 0, 2, 5
p windowed_max_range([1, 0, 2, 5, 4, 8], 4) == 6 # 2, 5, 4, 8
p windowed_max_range([1, 3, 2, 5, 4, 8], 5) == 6 # 3, 2, 5, 4, 8
