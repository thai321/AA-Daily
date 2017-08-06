# Implement a method that finds the sum of the first n
# fibonacci numbers recursively. Assume n > 0
def fibs_sum(n) # my version
  return 1 if n == 1
  return 2 if n == 2

  current = single_fib(n)
  current += fibs_sum(n - 1)
end

def single_fib(n)
  return 1 if n == 1
  return 1 if n == 2

  single_fib(n - 1) + single_fib(n - 2)
end

def fibs_sum(n) # solution
  return 0 if n == 0
  return 1 if n == 1

  fibs_sum(n-1) + fibs_sum(n-2) + 1
end
