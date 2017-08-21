class Array

  def my_each(&prc)
    self.length.times do |i|
      prc.call(self[i])
    end
    self
  end

  def my_select(&prc)
    array = []
    self.my_each { |el| array << el if prc.call(el) }
    array
  end

  def my_reject(&prc)
    array = []
    self.my_each { |el| array << el unless prc.call(el) }
    array
  end

  def my_any?(&prc)
    self.my_each { |el| return true if prc.call(el) }
    false
  end

  def my_all?(&prc)
    self.my_each { |el| return false unless prc.call(el)}
    true
  end

  def my_flatten
    result = []

    self.my_each do |el|
      if el.class == Array
        result += el.my_flatten
      else
        result << el
      end
    end
    result
  end

  def my_zip(*arrays)
    result = []

    self.each_with_index do |el, i|
      subArray = [el]
      arrays.my_each do |array|
        subArray << array[i]
      end
      result << subArray
    end
    result
  end

  def my_rotate(times=1)
    times = times % self.length
    self[times..-1] + self[0...times]
  end

  def my_join(sep='')
    result = ''
    self.each_with_index do |el, i|
      if (i == self.length - 1)
        result += el
      else
        result += (el + sep)
      end
    end
    result
  end

  def my_reverse
    result = []
    idx = self.length - 1
    while idx > -1
      result << self[idx]
      idx -= 1
    end
    result
  end

  def my_reverse2
    helper(self,[])
  end

  def helper(arr,result)
    return result if (arr.length == 0)
    helper(arr[0...-1], result << arr[-1])
  end
end
