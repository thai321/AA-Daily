class Array
  # Write a method, `Array#two_sum`, that finds all pairs of positions where the
  # elements at those positions sum to zero.

  # NB: ordering matters. I want each of the pairs to be sorted smaller index
  # before bigger index. I want the array of pairs to be sorted
  # "dictionary-wise":
  #   [0, 2] before [1, 2] (smaller first elements come first)
  #   [0, 1] before [0, 2] (then smaller second elements come first)

  def two_sum
    length = self.length - 1
    arr = []

    (0..length - 1).each do |i|
      ((i + 1)..length).each do |j|
        arr << [i, j] if  (self[i] + self[j] == 0)
      end
    end

    arr
  end
end
