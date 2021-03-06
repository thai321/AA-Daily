require_relative 'p05_hash_map'

def can_string_be_palindrome?(string)
  # hash = Hash.new(0)
  hash = HashMap.new

  string.each_char do |char|
    if hash[char]
      hash[char] += 1
    else
      hash[char] = 1
    end
  end

  odds = 0
  hash.each do |char, count|
    odds += 1 if count.odd?
    if string.length.odd? && odds > 1
      return false
    elsif string.length.even? && odds > 0
      return false
    end
  end

  return true
end
