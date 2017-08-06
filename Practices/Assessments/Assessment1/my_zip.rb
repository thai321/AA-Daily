class Array

  def my_zip(*arrs)
    arr = []

    self.each_with_index do |el, i|
      subArr = [el]
      arrs.each { |arr| subArr << arr[i] }
      arr << subArr
    end

    arr
  end

end
