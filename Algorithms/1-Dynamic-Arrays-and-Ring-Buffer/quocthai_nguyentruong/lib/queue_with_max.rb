# Implement a queue with #enqueue and #dequeue, as well as a #max API,
# a method which returns the maximum element still in the queue. This
# is trivial to do by spending O(n) time upon dequeuing.
# Can you do it in O(1) amortized? Maybe use an auxiliary storage structure?

# Use your RingBuffer to achieve optimal shifts! Write any additional
# methods you need.

require_relative 'ring_buffer'
require 'byebug'

class QueueWithMax
  attr_accessor :store

  def initialize
    @store_in = RingBuffer.new
    @store_out = RingBuffer.new
  end

  def enqueue(val)
    @store_in.push(val)
  end

  def dequeue
    # Only do this once for every n operations --> amortize O(1)
    if @store_out.length == 0
      @store_out.push(@store_in.shift) until @store_in.length == 0
    end
    @store_out.shift
  end

  def max
    arr = []
    arr << @store_in.max if !(@store_in.length == 0)
    arr << @store_out.max if !(@store_out.length == 0)
    arr.max
  end

  def length
    @store_in.length + @store_out.length
  end

  def empty?
    @store_in.length == 0 && @store_out.length == 0
  end

end
