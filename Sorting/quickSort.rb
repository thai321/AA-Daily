def quick_sort(arr)
  return [] if arr.empty?
  return [arr.first] if arr.length == 1

  pivot = arr.first

  left = arr[1..-1].select { |n| n <= pivot }
  right = arr[1..-1].select { |n| n > pivot }

  return quick_sort(left) + [pivot] + quick_sort(right)
end

arr = [4, 12, 3, 9, 8, 2, 7]
p quick_sort(arr)
