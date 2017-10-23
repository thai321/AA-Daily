require_relative 'heap'

def k_largest_elements(array, k)
  heap = BinaryMinHeap.new
  new_array = array.dup
  new_array.each { |num| heap.push(num) }
  (0...new_array.length).each { |i| new_array[i] = heap.extract }

  new_array[-k..-1]
end
