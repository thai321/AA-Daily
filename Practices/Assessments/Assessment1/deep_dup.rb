# Using recursion and the is_a? method,
# write an Array#deep_dup method that will perform a "deep" duplication of the interior arrays.


def deep_dup(arr)
  arr.map do |el|
    if el.is_a? Array
      deep_dup(el)
    else
      el
    end
  end
end
