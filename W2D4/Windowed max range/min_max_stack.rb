require_relative 'stack'

class MinMaxStack
  attr_reader :store

  def initialize(store=[])
    @store = MyStack.new
  end

  def min
    @store.peek[:min] if !empty?
  end

  def max
    @store.peek[:max] if !empty?
  end

  def pop
    @store.pop[:val] if !empty?
  end

  def peek
    @store.peek[:val]
  end

  def push(val)
    min_value = empty? ? val : [min, val].min
    max_value = empty? ? val : [max, val].max

    data = {
      val: val,
      min: min_value,
      max: max_value
    }

    @store.push(data)
  end

  def size
    @store.size
  end

  def empty?
    @store.empty?
  end

  def show
    @store.show
  end

end
