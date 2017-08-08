# Write a method that returns the factors of a number in ascending order.

def factors(num)
  return 1 if num == 1

  (1..num).select { |n| (num % n) == 0 }
end
