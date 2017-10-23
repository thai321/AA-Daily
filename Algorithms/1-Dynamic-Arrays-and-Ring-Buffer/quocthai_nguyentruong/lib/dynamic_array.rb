require_relative "static_array"
require 'byebug'

class DynamicArray
  include Enumerable
  attr_reader :length

  def initialize
    @store = StaticArray.new(8)
    @length = 0
    @capacity = 8
  end

  # O(1)
  def [](index)
    if @store[index]
      @store[index]
    else
      raise 'index out of bounds'
    end
  end

  # O(1)
  def []=(index, value)
    @store[index] = value
  end

  # O(1)
  def pop
    raise 'index out of bounds' if @length == 0
    result = @store[@length - 1]
    @length -= 1
    result
  end

  # O(1) ammortized; O(n) worst case. Variable because of the possible
  # resize.
  def push(val)
    resize! if @length == @capacity
    @store[@length] = val
    @length += 1

  end

  # O(n): has to shift over all the elements.
  def shift
    raise 'index out of bounds' if @length == 0
    new_array = StaticArray.new(@capacity)

    (0...@length).each do |i|
      new_array[i] = @store[i + 1]
    end

    @length -= 1
    result = @store[0]
    @store = new_array
    result
  end

  # O(n): has to shift over all the elements.
  def unshift(val)
    resize! if @length == @capacity
    # byebug

    new_array = StaticArray.new(@capacity)
    new_array[0] = val

    (0...@length).each do |i|
      new_array[i + 1] = @store[i]
    end

    @length += 1
    @store = new_array
  end


  protected
  attr_accessor :capacity, :store
  attr_writer :length

  def check_index(index)
    raise 'index out of bounds' if index >= @length
  end

  # O(n): has to copy over all the elements to the new store.
  def resize!
    new_array = StaticArray.new(@capacity * 2)
    self.each_with_index do |el, i|
      new_array[i] = el
    end
    @capacity *= 2
    @store = new_array
  end

  def each
    (0...@length).each do |i|
      yield(@store[i])
    end
  end
end
