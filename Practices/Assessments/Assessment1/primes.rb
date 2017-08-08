# primes(num) returns an array of the first "num" primes.
# You may wish to use an is_prime? helper method.

def is_prime?(num)
  return false if num == 0
  return true if num == 2

  (2..Math.sqrt(num)).none? { |n| (num % n) == 0 }
end

def primes(num)
  return [] if num == 0
  return [2] if num == 1

  arr = [2]
  i = 3
  until (arr.length == num)
    arr << i if is_prime?(i)
    i += 1
  end

  arr
end
