# Write a method that returns the median of elements in an array
# If the length is even, return the average of the middle two elements
class Array
  def median
    return nil if self.empty?
    return self[0] if self.length == 1
    copy = self.sort

    mid = copy.length / 2
    copy.length.even? ? (copy[mid-1] + copy[mid])/2.0 : copy[mid]
  end
end
