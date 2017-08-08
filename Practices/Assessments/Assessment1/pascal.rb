
def pascal(n)
  return [1] if n == 1
  return [1, 1] if n == 2

  arr =[1]
  mid_func = pascal(n-1)

  (0..(mid_func.length - 2)).each do |i|
    arr << mid_func[i] + mid_func[i + 1]
  end

  arr << 1
  arr
end

p pascal(1) == [1]
p pascal(2) == [1, 1]
p pascal(3) == [1, 2, 1]
p pascal(4) == [1, 3, 3, 1]
p pascal(5) == [1, 4, 6, 4, 1]
