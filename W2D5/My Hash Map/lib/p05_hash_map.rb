require_relative 'p02_hashing'
require_relative 'p04_linked_list'

require 'byebug'

class HashMap
  include Enumerable

  attr_reader :count, :store

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { LinkedList.new }
    @count = 0
  end

  def include?(key)
    bucket(key).include?(key)
  end

  def set(key, val)
    if include?(key)
      bucket(key).update(key, val)
    else
      resize! if @count == num_buckets
      bucket(key).append(key, val)
      @count += 1
    end
  end

  def get(key)
    bucket(key).get(key)
    # bucket(key)
  end

  def delete(key)
    bucket(key).remove(key)
    @count -= 1
  end

  def each
    @store.each do |bucket|
      bucket.each do |node|
        yield [node.key, node.val]
      end
    end
  end

  # uncomment when you have Enumerable included
  # def to_s
  #   pairs = inject([]) do |strs, (k, v)|
  #     strs << "#{k.to_s} => #{v.to_s}"
  #   end
  #   "{\n" + pairs.join(",\n") + "\n}"
  # end

  alias_method :[], :get
  alias_method :[]=, :set

  private

  def num_buckets
    @store.length
  end

  def resize!
    new_hash_map = HashMap.new(num_buckets * 2)
    @store.each do |bucket|
      bucket.each do |node|
        new_hash_map.set(node.key, node.val)
      end
    end

    @store = new_hash_map.store
  end

  def bucket(key)
    # optional but useful; return the bucket corresponding to `key`
    @store[key.hash % num_buckets]
  end
end
