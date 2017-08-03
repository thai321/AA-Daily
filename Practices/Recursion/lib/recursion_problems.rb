#Problem 1: You have array of integers. Write a recursive solution to find the
#sum of the integers.

def sum_recur(array)
  return 0 if array.empty?
  return array[0] if array.length == 1

  array[0] + sum_recur(array[1..-1])
end

#Problem 2: You have array of integers. Write a recursive solution to determine
#whether or not the array contains a specific value.

def includes?(array, target)
  return false if array.empty?
  return true if array[0] == target

  includes?(array[1..-1], target)
end

# Problem 3: You have an unsorted array of integers. Write a recursive solution
# to count the number of occurrences of a specific value.

def num_occur(array, target)
  return 0 if array.empty?
  if array[0] == target
    1 + num_occur(array[1..-1], target)
  else
    num_occur(array[1..-1], target)
  end
end

# Problem 4: You have array of integers. Write a recursive solution to determine
# whether or not two adjacent elements of the array add to 12.

def add_to_twelve?(array)
  return false if array.length <= 1
  if (array[0] + array[1]) == 12
    true
  else
    add_to_twelve?(array[1..-1])
  end
end

# Problem 5: You have array of integers. Write a recursive solution to determine
# if the array is sorted.

def sorted?(array)
  return true if array.length <= 1

  if array[0] > array[1]
    return false
  else
    sorted?(array[1..-1])
  end
end

# Problem 6: Write a recursive function to reverse a string. Don't use any
# built-in #reverse methods!

def reverse(string)
  return string if string.length <= 1

  reverse(string[1..-1]) + string[0]
end
