require 'byebug'

class Array

  # Write a monkey patch of binary search:
  # E.g. [1, 2, 3, 4, 5, 7].my_bsearch(5) => 4
  def my_bsearch(target, &prc)
    prc ||= Proc.new { |x, y| x <=> y }
    if self.length == 1 and prc.call(self[0], target) != 0
      return nil
    end

    mid = self.length/2
    if prc.call(self[mid], target) == 0
      return mid
    elsif prc.call(self[mid], target) == 1
      self[0...mid].my_bsearch(target, &prc)
    else # -1
      bsearch = self[(mid + 1)..-1].my_bsearch(target, &prc)
      if !bsearch.nil?
        mid + 1 + bsearch
      end
    end
  end
end

p [1,2,3].my_bsearch(1) == 0
p [2, 3, 4, 5].my_bsearch(3) == 1
p [2, 4, 6, 8, 10].my_bsearch(6) == 2
p [1, 3, 4, 5, 9].my_bsearch(5) == 3
p [1, 2, 3, 4, 5, 6].my_bsearch(6) == 5
p [1, 2, 3, 4, 5, 6].my_bsearch(0) == nil
p [1, 2, 3, 4, 5, 7].my_bsearch(6) == nil
