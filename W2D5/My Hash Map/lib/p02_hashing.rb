require 'byebug'

class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    return 0 if self.empty?

    sum = 0
    self.each_with_index do |el, i|
      temp = 0
      if el.is_a? String
        temp = el.to_s.ord
        sum += i + temp
      elsif el.is_a? Array
        temp = el.hash
        sum += i + temp
      else
        sum += i * el
      end

    end

    sum
  end
end

class String
  def hash
    return self.ord if self.length == 1

    sum = 0
    self.chars.each_with_index do |char, i|
      sum += i * char.ord
    end

    sum
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    sum = 0

    self.each do |k, v|
      sum += k.to_s.ord * v.to_s.ord
    end

    sum
  end
end
