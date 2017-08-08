require 'byebug'

# Jumble sort takes a string and an alphabet. It returns a copy of the string
# with the letters re-ordered according to their positions in the alphabet. If
# no alphabet is passed in, it defaults to normal alphabetical order (a-z).

# Example:
# jumble_sort("hello") => "ehllo"
# jumble_sort("hello", ['o', 'l', 'h', 'e']) => 'ollhe'

def jumble_sort(str, alphabet = nil)
  return str.chars.sort.join if alphabet.nil?

  arr = []
  i = 0
  alphabet.each do |char|
    break if i >= str.length

    if str.include?(char) && !arr.include?(char)
      count = str.count(char)
      arr << char * count
      i += count
    end
  end

  arr.join
end
