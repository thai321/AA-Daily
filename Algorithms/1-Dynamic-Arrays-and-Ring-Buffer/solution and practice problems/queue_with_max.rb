# Implement a queue with #enqueue and #dequeue, as well as a #max API,
# a method which returns the maximum element still in the queue. This
# is trivial to do by spending O(n) time upon m dequeues >> O(n*m).
# Can you do it in O(n) amortized? Maybe use an auxiliary storage structure?

# Use your RingBuffer to achieve optimal shifts!

require_relative 'ring_buffer'

class QueueWithMax
  attr_reader :store, :maxque

  def initialize
    @store = RingBuffer.new
    @maxque = RingBuffer.new
  end

  def enqueue(el)
    @store.push(el)
    update_maxque(el)
  end

  def dequeue
    val = @store.shift
    @maxque.shift if val == maxque[0]
    val
  end

  def max
    @maxque[0] if @maxque.length > 0
  end

  def update_maxque(el)
    while @maxque[0] && @maxque[@maxque.length-1] < el
      @maxque.pop
    end
    @maxque.push(el)
  end

  def length
    @store.length
  end
end
