class Array

  def my_select(&prc)
    arr = []

    self.each { |el| arr << el if prc.call(el) }

    arr
  end

end
