class Array

  # Write an Array#merge_sort method; it should not modify the original array.

  def merge_sort(&prc)
    prc ||= Proc.new { |x, y| x <=> y }

    return self if self.length <= 1

    mid = self.length / 2

    left = self[0...mid].merge_sort(&prc)
    right = self[mid..-1].merge_sort(&prc)

    Array.merge(left, right, &prc)
  end

  private
  def self.merge(left, right, &prc)
    i, j = 0, 0
    new_arr = []
    while i < left.length && j < right.length
      if prc.call(left[i], right[j]) == -1
        new_arr << left[i]
        i += 1
      else
        new_arr << right[j]
        j += 1
      end
    end

    new_arr.concat(left[i..-1] + right[j..-1])
    new_arr
  end
end
