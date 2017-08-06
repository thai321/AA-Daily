# Write a recursive method that returns the sum of all elements in an array
def rec_sum(nums)
  return 0 if nums.empty?
  return nums[0] if nums.length == 1

  nums[0] + rec_sum(nums[1..-1])
end
