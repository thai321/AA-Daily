require 'byebug'

#Warmup
def range_iter(start, stop)
  arr = []
  start.upto(stop - 1) { |n| arr << n }
  arr
end

def range_recursive(start, stop)
  if start == stop
    return []
  end
  [start] + range_recursive(start + 1, stop)
end

def range_recursive2(start, stop, acc)
  if start == stop
    return acc
  end
  range_recursive2(start + 1, stop, acc + [start])
end

# Exponential
def exp1(b, n)
  return 1 if n == 0
  exp1(b, n - 1) * b
end


def exp2(b, n)
  return 1 if n == 0

  if n.even?
    exp2(b,n/2) ** 2
  else
    b * exp2(b, ((n - 1) / 2)) ** 2
  end
end


#Deep dup
class Array
  def deepdup
    arr = Array.new
    self.each do |el|
      unless el.is_a? Array
        arr << el
      else
        arr << el.deepdup
      end
    end
    arr
  end
end

=begin
robot_parts = [
  ["nuts", "bolts", "washers"],
  ["capacitors", "resistors", "inductors"]
]

robot_parts_copy = robot_parts.deepdup
robot_parts_copy[1] << "LEDs"

p robot_parts_copy
p robot_parts
=end



# Fibonacci

def fib_rec(n)
  if n == 1
    [1]
  elsif n == 2
    [1,1]
  else
    prev = fib_rec(n-1)
    prev += [prev[-1] + prev[-2]]
    return prev
  end
end

$memo={1 => [1], 2 => [1,1]}

def fib_rec_cache(n)
  if $memo.key?(n)
    return $memo[n]
  else
    $memo[n-1] = fib_rec_cache(n-1)
    new_num = $memo[n-1][-1] + $memo[n-1][-2]
    $memo[n] = $memo[n-1] + [new_num]
  end
end

# p fib_rec_cache(5)


def subsets(arr)
  if arr.empty?
    [[]]
  else
    subArray = subsets(arr[0...-1])
    subArray += subArray.map { |el| el += [arr.last] }
    subArray
  end
end

=begin
p subsets([]) #== [[]]
p subsets([1]) #== [[], [1]]
p subsets([1, 2])  #== [[], [1], [2], [1, 2]]
p subsets([1, 2, 3]) #== [[], [1], [2], [1, 2], [3], [1, 3], [2, 3], [1, 2, 3]]
=end


# Permuations
def permutations(arr)
  if arr.length == 1
    return [arr]
  else
    new_arr = []
    arr.each_index do |idx|
      subArray = permutations(arr[0...idx] + arr[idx + 1..-1])
      new_arr += subArray.map { |subarr| [(arr[idx])] + subarr }
    end
    new_arr
  end
end

# p permutations([1, 2, 3])


# Binary Search

def bsearch(arr, value)
  mid = arr.length / 2

  if mid == 0
    return arr[mid] == value ? mid : nil
  end

  if arr[mid] == value
    return mid
  elsif arr[mid] > value
    return bsearch(arr[0...mid], value)
  else
    return bsearch(arr[mid + 1..-1], value)
  end
end

=begin
p bsearch([1, 2, 3], 1) # => 0
p bsearch([2, 3, 4, 5], 3) # => 1
p bsearch([2, 4, 6, 8, 10], 6) # => 2
p bsearch([1, 3, 4, 5, 9], 5) # => 3
p bsearch([1, 2, 3, 4, 5, 6], 6) # => 5
p bsearch([1, 2, 3, 4, 5, 6], 0) # => nil
p bsearch([1, 2, 3, 4, 5, 7], 6) # => nil
=end

# Merge Sort
class Array
  def merge_sort
    if self.length < 2
      self
    else
      mid = self.length / 2
      left_branch = self[0...mid].merge_sort
      right_branch = self[mid..-1].merge_sort
      (left_branch).merge(right_branch)
    end
  end

  def merge(other)
    # byebug
    new_arr = []
    i, j = 0, 0
    while i < self.length && j < other.length
      if self[i] < other[j]
        new_arr << self[i]
        i += 1
      else
        new_arr << other[j]
        j += 1
      end
    end
    new_arr = new_arr + self[i..-1] + other[j..-1]
    new_arr
  end
end

=begin
x = (1..10).to_a.shuffle
p x
p x.merge_sort!
p x
=end


# Make Change

def greedy_make_change(amount, coins = [25, 10, 5, 1])
  change = []
  change += [coins.first] * (amount / coins.first)
  amount %= coins.first
  if amount == 0
    change
  else
    change += greedy_make_change(amount, coins[1..-1])
  end
end

# p greedy_make_change(39)
# p greedy_make_change(24, [10,7,1])
# p greedy_make_change(14, [10, 7, 1])


def better_change(amount, coins = [25, 10, 5, 1])
  possible_changes = []
  return [] if amount <= 0

  coins.each do |coin|

    if amount >= coin
      possible_changes << [coin] + better_change(amount - coin, coins)
    end
  end

  if possible_changes.empty?
    []
  else
    possible_changes.min_by(&:length)
  end
end


#p better_change(39)
# p better_change(24, [10,7,1])
# p better_change(14, [10, 7, 1])
