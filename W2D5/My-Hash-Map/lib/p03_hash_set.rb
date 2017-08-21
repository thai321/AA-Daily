require 'byebug'
require_relative 'p02_hashing'

class HashSet
  attr_reader :count , :store

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    resize! if @count == num_buckets
    if !include?(key)
      self[key] << key
      @count += 1
    end
  end

  def include?(key)
    return false if !self[key].include?(key)
    true
  end

  def remove(key)
    self[key].delete(key) if include?(key)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    # byebug
    @store[num.hash % num_buckets]
  end

  def num_buckets
    @store.length
  end

  def resize!
    new_set = HashSet.new(num_buckets * 2)
    @store.each do |bucket|
      bucket.each do |el|
        new_set.insert(el)
      end
    end
    @store = new_set.store

  end
end
