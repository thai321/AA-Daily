require_relative 'stack'

# Use 2 Stack to implement a Queue
class StackQueue

  def initialize
    @stack_in = MyStack.new
    @stack_out = MyStack.new
  end

  def enqueue(val)
    @stack_in.push(val)
  end

  def dequeue
    # Only do this once for every n operations --> amortize O(1)
    @stack_out.push(@stack_in.pop) until @stack_in.empty?
    @stack_out.pop
  end

  def size
    @stack_in.size + @stack_out.size
  end

  def empty?
    @stack_in.empty? && @stack_out.empty?
  end
end
