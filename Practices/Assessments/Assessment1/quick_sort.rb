require 'byebug'

class Array

  #Write a monkey patch of quick sort that accepts a block
  def my_quick_sort(&prc)
    prc ||= Proc.new { |x, y| x <=> y }

    return self if self.length <= 1

    pivot = self.first

    left = self[1..-1].select { |n| prc.call(n, pivot) == -1 }
    right = self[1..-1].select { |n| prc.call(n,pivot) != -1 }

    left.my_quick_sort(&prc) + [pivot] + right.my_quick_sort(&prc)
  end
end
