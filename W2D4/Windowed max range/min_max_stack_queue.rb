require_relative 'min_max_stack'

# Use 2 Stack to implement a Queue
class MinMaxStackQueue

  def initialize
    @stack_in = MinMaxStack.new
    @stack_out = MinMaxStack.new
  end

  def show_stack
    puts "Stack IN: " , @stack_in.show
    puts "Stack Out: " , @stack_out.show
  end

  def min
    arr = []
    arr << @stack_in.min if !@stack_in.empty?
    arr << @stack_out.min if !@stack_out.empty?
    arr.min
  end

  def max
    arr = []
    arr << @stack_in.max if !@stack_in.empty?
    arr << @stack_out.max if !@stack_out.empty?
    arr.max
  end

  def enqueue(val)
    @stack_in.push(val)
  end

  def dequeue
    # Only do this once for every n operations --> amortize O(1)
    if @stack_out.empty?
      @stack_out.push(@stack_in.pop) until @stack_in.empty?
    end
    @stack_out.pop
  end

  def size
    @stack_in.size + @stack_out.size
  end

  def empty?
    @stack_in.empty? && @stack_out.empty?
  end

end
