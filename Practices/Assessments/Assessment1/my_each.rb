class Array

  def my_each(&prc)
    prc ||= Proc.new { |x, y|  x <=> y }

    self.length.times { |i| prc.call(self[i]) }
  end

  def my_each_with_index(&prc)
    prc ||= Proc.new { |x, y| x <=> y }

    self.length.times { |i| prc.call(self[i], i) }
  end

end
