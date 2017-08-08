require 'byebug'

class Array

  # Takes a multi-dimentional array and returns a single array of all the elements
  # [1,[2,3], [4,[5]]].my_controlled_flatten(1) => [1,2,3,4,5]
  def my_flatten
    arr = []

    self.each do |el|
      if el.is_a? Array
        arr += el.my_flatten
      else
        arr << el
      end
    end

    arr
  end

  # Write a version of flatten that only flattens n levels of an array.
  # E.g. If you have an array with 3 levels of nested arrays, and run
  # my_flatten(1), you should return an array with 2 levels of nested
  # arrays
  #
  # [1,[2,3], [4,[5]]].my_controlled_flatten(1) => [1,2,3,4,[5]]
  def my_controlled_flatten(n)
    return self if n <= 0

    arr = []

    self.each do |el|
      if (el.is_a? Array) && n > 0
        arr += el.my_controlled_flatten(n - 1)
      else
        arr << el
      end
    end

    arr
  end
end
