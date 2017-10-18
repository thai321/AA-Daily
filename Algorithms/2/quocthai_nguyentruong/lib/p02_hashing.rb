class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    total = 0

    self.each_with_index do |el, i|
      total += (i * el.hash)
    end

    total
  end
end

class String
  def hash
    total = 0

    self.split('').each_with_index do |char, i|
      total += (i * char.ord)
    end

    total
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    total = 0
    self.each do |k, v|
      total += (k.hash + v.hash)
    end

    total
  end
end
