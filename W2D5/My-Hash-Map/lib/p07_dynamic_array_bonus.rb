require 'byebug'

class StaticArray
  def initialize(capacity)
    @store = Array.new(capacity)
  end

  def [](i)
    validate!(i)
    @store[i]
  end

  def []=(i, val)
    validate!(i)
    @store[i] = val
  end

  def length
    @store.length
  end

  private

  def validate!(i)
    raise "Overflow error" unless i.between?(0, @store.length - 1)
  end
end

class DynamicArray
  include Enumerable

  attr_reader :count

  def initialize(capacity = 8)
    @store = StaticArray.new(capacity)
    @count = 0
    @start = 0
  end

  def [](i)
    @store[(@start + i) % capacity]
  end

  def []=(i, val)
    @store[(@start + i) % capacity] = val
  end

  def capacity
    @store.length
  end

  def include?(val)
    # byebug
    return false if @count == 0
    (0..(@count - 1)).each do |i|
      return true if @store[i] == val
    end
    false
  end

  def push(val)
    self[@count] = val
    @count += 1
    self
  end

  def unshift(val)
  end

  def pop
    return nil if @count == 0
    temp = self.last
    @count -= 1
    temp
  end

  def shift
  end

  def first
    self[0]
  end

  def last
    self[@count - 1]
  end

  def each
    (0...@count).each do |i|
        yield(self[i])

    end
    self
  end

  def to_s
    "[" + inject([]) { |acc, el| acc << el }.join(", ") + "]"
  end

  def ==(other)
    return false unless [Array, DynamicArray].include?(other.class)
    # ...
  end

  alias_method :<<, :push
  [:length, :size].each { |method| alias_method method, :count }

  private

  def resize!
  end
end
