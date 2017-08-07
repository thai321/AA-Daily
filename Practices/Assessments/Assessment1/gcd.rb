
def gcdIterative(num1, num2)
  while(num2 != 0)
    temp = num2
    num2 = num1 % num2
    num1 = temp
  end

  num1
end

def gcdRecursive(num1, num2)
  return num1 if(num2 == 0);

  return gcdRecursive(num2 ,num1 % num2);
end

p gcdIterative(30, 100) == 10
p gcdIterative(100, 30) == 10
