require 'byebug'
# Write a recursive method that returns all of the permutations of an array
def permutations(array)
  return [array]  if array.length == 1

  result = []

  array.each_index do |i|
    subArrays = permutations(array[0...i] + array[(i + 1)..-1])
    result += subArrays.map { |subArr| [array[i]] + subArr  }
  end

  result
end
