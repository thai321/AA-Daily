require_relative "heap"

class Array
  def heap_sort!
    heap = BinaryMinHeap.new
    self.each { |num| heap.push(num) }
    (0...length).each { |i| self[i] = heap.extract }
  end
end
