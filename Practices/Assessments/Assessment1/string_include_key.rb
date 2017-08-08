require 'byebug'
# Write a recursive method that takes in a string to search and a key string.
# Return true if the string contains all of the characters in the key
# in the same order that they appear in the key.
#
# string_include_key?("cadbpc", "abc") => true
# string_include_key("cba", "abc") => false
def string_include_key?(string, key)
  i = 0
  string.chars.each do |char|
    if key.include?(char) && char != key[i]
      return false
    elsif char == key[i]
      i += 1
    end
  end

  (i == key.length) ? true : false
end
