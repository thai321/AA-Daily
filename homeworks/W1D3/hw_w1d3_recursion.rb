
def sum_to(n)
  return nil if n < 0
  return 1 if n == 1

  n + sum_to(n - 1)
end

p sum_to(5) # 15
p sum_to(1) # 1
p sum_to(9) # 45
p sum_to(-8) # nil

p '----------------'
def add_numbers(arr)
  return nil if arr.empty?
  return arr[0] if arr.length == 1

  arr.pop + add_numbers(arr)
end

p add_numbers([1,2,3,4]) # 10
p add_numbers([3]) # 3
p add_numbers([-80, 34, 7]) # -39
p add_numbers([]) # nil

p '-----------------'

def gamma_fnc(n)
  return nil if n == 0
  return 1 if n <= 2

  (n - 1) * gamma_fnc(n - 1)
end

p gamma_fnc(0) # nil
p gamma_fnc(1) # 1
p gamma_fnc(4) # 6
p gamma_fnc(8) # 5040


p '-----------------'

def ice_cream_shop(flavors, favorite)
  return false if flavors.empty?
  return true if flavors.pop == favorite

  ice_cream_shop(flavors, favorite)
end


p ice_cream_shop(['vanilla', 'strawberry'], 'blue moon')  # => returns false
p ice_cream_shop(['pistachio', 'green tea', 'chocolate', 'mint chip'], 'green tea')  # => returns true
p ice_cream_shop(['cookies n cream', 'blue moon', 'superman', 'honey lavender', 'sea salt caramel'], 'pistachio')  # => returns false
p ice_cream_shop(['moose tracks'], 'moose tracks')  # => returns true
p ice_cream_shop([], 'honey lavender')  # => returns false


p '----------------'

def reverse(string)
  return '' if string == ''

  string[-1] + reverse(string[0...-1])
end

# Test Cases
p reverse("house") # => "esuoh"
p reverse("dog") # => "god"
p reverse("atom") # => "mota"
p reverse("q") # => "q"
p reverse("id") # => "di"
p reverse("") # => ""
