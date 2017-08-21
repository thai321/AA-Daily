require 'byebug'

class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    sum = 0
    self.each_with_index do |el, i|
      sum += (i * el.hash)
    end

    sum
  end
end

class String
  def hash
    return self.ord if self.length == 1

    sum = 0
    self.chars.each_with_index do |char, i|
      sum += (i * char.ord)
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
