class Array

  def my_rotate(num=1)
    num = num % self.length
    self[num..-1] + self[0...num]
  end

end
