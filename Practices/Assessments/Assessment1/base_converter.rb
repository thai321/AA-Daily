# Write a recursive method that takes in a base 10 number n and
# converts it to a base b number. Return the new number as a string
#
# E.g. base_converter(5, 2) == "101"
# base_converter(31, 16) == "1f"
DIGITS = ('0'..'9').to_a + ('a'..'f').to_a
def base_converter(num, b)
  return DIGITS[num] if num < b

  base_converter(num/b, b) + DIGITS[num % b]
end
