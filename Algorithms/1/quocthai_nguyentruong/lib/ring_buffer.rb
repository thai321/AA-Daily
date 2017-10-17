require_relative "static_array"

class RingBuffer
  attr_reader :length

  def initialize
    @store = StaticArray.new(8)
    @capacity = 8
    @start_idx = 0
    @length = 0
  end

  # O(1)
  def [](index)
    check_index(index)
    @store[offset(index)]
  end

  # O(1)
  def []=(index, val)
    @store[offset(index)] = val
  end

  # O(1)
  def pop
    raise 'index out of bounds' if @length == 0
    result = @store[offset(@length) - 1]
    @length -= 1
    result
  end

  # O(1) ammortized
  def push(val)
    resize! if @length == @capacity
    @store[offset(@length)] = val
    @length += 1
  end

  # O(1)
  def shift
    raise 'index out of bounds' if @length == 0
    result = @store[@start_idx]
    @start_idx = offset(1)
    @length -= 1
    result
  end

  # O(1) ammortized
  def unshift(val)
    resize! if @length == @capacity
    @start_idx = offset(-1)
    @store[@start_idx] = val
    @length += 1
  end

  def offset(index)
    (@start_idx + index) % @capacity
  end

  protected
  attr_accessor :capacity, :start_idx, :store
  attr_writer :length

  def check_index(index)
    raise 'index out of bounds' if @length <= 0 || index > @length -1
  end

  def resize!
    new_array = StaticArray.new(@capacity * 2)
    new_start = @start_idx + @capacity

    (0...@length).each do |i|
      offset_index = (new_start + i) % (@capacity  * 2)
      new_array[offset_index] = @store[offset(i)]
    end

    @start_idx = new_start
    @capacity *= 2
    @store = new_array
  end
end
