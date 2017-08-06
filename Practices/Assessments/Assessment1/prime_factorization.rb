# Write a recursive function that returns the prime factorization of
# a given number. Assume num > 1
#
# prime_factorization(12) => [2,2,3]
def prime_factorization(num)
  return [] if num == 1
  return [num] if is_prime?(num)

  i = 2
  i += 1 until is_prime?(i) && (num % i) == 0

  arr = [i]
  arr += prime_factorization(num / i)
end

def is_prime?(num)
  return true if num == 2

  (2..Math.sqrt(num)).none? { |n| (num % n) == 0 }
end
