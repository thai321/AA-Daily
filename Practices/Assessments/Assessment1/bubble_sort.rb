require 'byebug'

class Array
  def bubble_sort!
    # byebug
    return self if self.length <= 1

    (self.length - 1).downto(1) do |i|
      0.upto(i - 1) do |j|
        if self[j] > self[j + 1]
          self[j], self[j + 1] = self[j + 1], self[j]
        end
      end
    end
    self
  end

  def bubble_sort!(&prc) # with proc
    prc ||= Proc.new { |x, y| x <=> y }
    return self if self.length <= 1

    (self.length - 1).downto(1) do |i|
      0.upto(i - 1) do |j|
        if prc.call(self[j], self[j + 1]) == 1
          self[j], self[j + 1] = self[j + 1], self[j]
        end
      end
    end
    self
  end

  def bubble_sort(&prc)
    self.dup.bubble_sort!
  end
end
