# Phase I
=begin
First, write a function that compares each element to every
other element of the list. Return the element if all other elements in the array are larger.
What is the time complexity for this function?
=end

# O(n^2)

def my_min1(list)
  min_value = list[0]

  list.each do |el1|
    current_min = el1
    list.each do |el2|
      if el2 < current_min && el2 < min_value
        min_value = el2
      elsif el1 < min_value
        min_value = el1
      end
    end
  end

  min_value
end

list = [ 0, 3, 5, 4, -5, 10, 1, 9]
p my_min1(list) == -5


# Phase 2
# O(n)
# Now rewrite the function to iterate through
# the list just once while keeping track of the minimum.
# What is the time complexity?

def my_min2(list)
  min_value = list[0]

  list[1..-1].each do |el|
    min_value = el if el < min_value
  end

  min_value
end

list = [ 0, 3, 5, 4, -5, 10, 1, 9]
p my_min2(list) == -5



# ---------------------------------------------------

# Largest Contiguous Sub-sum

# Phase I
# Write a function that iterates through the array and
# finds all sub-arrays using nested loops.
# First make an array to hold all sub-arrays. Then find the sums of each sub-array and return the max.
# O(n^2) time
# O(n^2) space
def largest_contiguous_subsum1(list)
  sub_arrs = []

  (0..list.length - 2).each do |i|
    (i+1..list.length - 1).each do |j|
      sub_arrs << list[i..j].inject(0) {|acc, el| acc + el}
    end
  end

  sub_arrs.max { |el, el2|  el <=> el2 }

end


list = [5, 3, -7]
p largest_contiguous_subsum1(list) == 8

list2 = [2, 3, -6, 7, -6, 7]
p largest_contiguous_subsum1(list2) == 8

#Phase II

# Let's make a better version. Write a new function using O(n)
# time with O(1) memory. Keep a running tally of the largest sum.

# O(n)
def largest_contiguous_subsum2(list)
  largest_sum = list[0]
  current_sum = list[0]

  list[1..-1].each do |el|
    current_sum = [current_sum + el, el].max
    largest_sum = [current_sum, largest_sum].max
  end

  largest_sum
end

list = [5, 3, -7]
p largest_contiguous_subsum2(list) == 8

list2 = [2, 3, -6, 7, -6, 7]
p largest_contiguous_subsum2(list2) == 8

list3 = [-5, -1, -3]
p largest_contiguous_subsum2(list3) == -1


# --------------------------------
# O(n) time
# O(4) = O(1) space
def largest_contiguous_subsum3(list)
  largest_sum = list[0]
  current_sum = list[0]
  x, y = [0,0]

  list.each_with_index do |el, i|
    next if i == 0

    if current_sum + el < el
      x = i
    end
    current_sum = [current_sum + el, el].max

    if current_sum > largest_sum
      y = i
    end
    largest_sum = [current_sum, largest_sum].max

  end

  [largest_sum, [x, y]]
end

list = [5, 3, -7]
p largest_contiguous_subsum3(list)

list2 = [2, 3, -6, 7, -6, 7]
p largest_contiguous_subsum3(list2)
