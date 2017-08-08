class String

  # Write a String#symmetric_substrings method that returns an array of substrings
  # that are palindromes, e.g. "cool".symmetric_substrings => ["oo"]
  # Only include substrings of length > 1.

  def symmetric_substrings
    length = self.length - 1
    arr = []

    (0..length-1).each do |i|
      (i..length).each do |j|
        str = self[i..j]
        arr << str if str.length > 2 && palindromes?(str)
      end
    end
    arr
  end

  def palindromes?(string)
    string == string.reverse
  end
end
