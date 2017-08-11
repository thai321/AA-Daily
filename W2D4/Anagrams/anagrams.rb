require 'byebug'
# --------------------------------
# Phase I
# time and space: O(n!)
def first_anagram?(s1, s2)
  all_poss = s1.chars.permutation.to_a

  all_poss.any? do |poss|
    s2 == poss.join
  end
end

p first_anagram?("gizmo", "sally")    #=> false
p first_anagram?("elvis", "lives")    #=> true

# --------------------------------
# Phase II
# time O(N^2)
# space O(N)

def second_anagram?(s1, s2)
  return false if s1.length != s2.length # O(1)

  # N(N + N + N) --> O(N^2)
  s1.chars.each do |char|
    # byebug
    return false if !s2.include?(char) # O(N)
    s1.delete!(char) # O(N)
    s2.delete!(char) # O(N)
  end

  s1.length == 0 && s2.length == 0
end

p second_anagram?("gizmo", "sally")    #=> false
p second_anagram?("elvis", "lives")    #=> true

# --------------------------------
# Phase III

# 0(NlogN)
#
def third_anagram?(s1, s2)
  s1.chars.sort.join == s2.chars.sort.join
end

p third_anagram?("gizmo", "sally")    #=> false
p third_anagram?("elvis", "lives")    #=> true


# --------------------------------
# Phase IV
# O(N) time
# O(1) space

def fourth_anagram?(s1, s2)
  frequency_hash = {}

  s1.chars do |ch|
    if frequency_hash[ch]
      frequency_hash[ch] += 1
    else
      frequency_hash[ch] = 1
    end
  end

  s2.chars do |ch|
    if frequency_hash[ch]
      frequency_hash[ch] -= 1
    end
  end

  frequency_hash.values.all? { |val| val == 0 }
end

p fourth_anagram?("gizmo", "sally")    #=> false
p fourth_anagram?("elvis", "lives")    #=> true

def fourth_anagram2?(s1, s2)
  hash = Hash.new(0)

  s1.chars.each { |ch| hash[ch] += 1 }
  s2.chars.each { |ch| hash[ch] -= 1 }

  hash.values.all? { |freq| freq == 0 }
end

p fourth_anagram2?("gizmo", "sally")    #=> false
p fourth_anagram2?("elvis", "lives")    #=> true
