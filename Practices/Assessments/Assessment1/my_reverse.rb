class Array

  def my_reverse
    return self if self.length == 1

    self[1..-1].my_reverse.concat([self[0]])
  end

end
