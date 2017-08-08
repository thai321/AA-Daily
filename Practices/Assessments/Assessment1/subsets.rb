#returns all subsets of an array
def subsets(array)
  return [[]] if array.empty?

  subset = subsets(array[0...-1])
  subset += subset.map { |arr| arr + [array.last] }
  subset
end
