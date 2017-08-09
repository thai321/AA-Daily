require 'byebug'


fishes = ['fish', 'fiiish', 'fiiiiish', 'fiiiish', 'fffish', 'ffiiiiisshh', 'fsh', 'fiiiissshhhhhh']

# Find the longest fish in O(n^2) time.
# Do this by comparing all fish lengths to all other fish lengths
def sluggish_octopus(fishes)
  length = fishes.length - 1


  (0..(length)).each do |i|
    longest = true

    ((i + 1)..length).each do |j|
      longest = false if fishes[j].length > fishes[i].length
    end

    return fishes[i] if longest == true
  end
end

p "sluggish_octopus: " + sluggish_octopus(fishes)

#  ------------------------------------------------------------------------

# Find the longest fish in O(n log n) time.
# Hint: You saw a sorting algorithm that runs in O(n log n)
# in the Sorting Demo. Remember that Big O is classified by the dominant term.

def merge_sort(fishes)
  return fishes if fishes.length == 1

  mid = fishes.length / 2

  left = merge_sort(fishes[0...mid])
  right = merge_sort(fishes[mid..-1])

  merge(left, right)
end

def merge(left, right)
  arr = []
  i, j = 0, 0

  while i < 0 && j < 0
    if left[i].length < right[j].length
      arr << left[i]
      i += 1
    else
      arr << right[j]
      j += 1
    end
  end

  arr.concat(left + right)
end

def dominant_octopus(fishes)
  merge_sort(fishes).last
end

p "dominant_octopus: " + dominant_octopus(fishes)

#  ------------------------------------------------------------------------

# Find the longest fish in O(n) time.
# The octopus can hold on to the longest fish
# that you have found so far while stepping through the array only once.

def clever_octopus(fishes)
  longest_fish = fishes.first

  fishes[1..-1].each do |fish|
    longest_fish = fish if fish.length > longest_fish.length
  end

  longest_fish
end

p "clever_octopus: " + clever_octopus(fishes)

#  ------------------------------------------------------------------------

# Given a tile direction, iterate through a tiles array
# to return the tentacle number (tile index)
# the octopus must move. This should take O(n) time.

tiles_array = ["up", "right-up", "right", "right-down", "down", "left-down", "left",  "left-up" ]

def slow_dance(dir, tiles_array)
  tiles_array.each_with_index do |tile, i|
    return i if tiles_array[i] == dir
  end
end

p "slow_dance: " + slow_dance("up", tiles_array).to_s
p "slow_dance: " + slow_dance("right-down", tiles_array).to_s


#  ------------------------------------------------------------------------

# Now that the octopus is warmed up,
# let's help her dance faster. Use a different data structure
# and write a new function so that you can access
# the tentacle number in O(1) time.

hash = Hash[tiles_array.map.with_index { |value, index| [value, index] }]

def fast_dance(dir, tiles_array)
  tiles_array[dir]
end

p "fast_dance: " + fast_dance("up", hash).to_s
p "fast_dance: " + fast_dance("right-down", hash).to_s
