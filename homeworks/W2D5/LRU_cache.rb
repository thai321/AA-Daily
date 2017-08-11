class LRUCache
  def initialize(size)
    @memo = []
    @size = size
  end

  def count
    @memo.count
  end

  def add(el)
    if @memo.include?(el)
      @memo.delete(el)
      @memo << el
    elsif count < @size
      @memo << el
    else
      @memo.shift
      @memo << el
    end
  end

  def show
    p @memo
  end

end


johnny_cache = LRUCache.new(4)

johnny_cache.add("I walk the line")
# => cache: "I walk the line"   size = 1

johnny_cache.add(5)
# => cache: "I walk the line" , 5   size = 2

johnny_cache.count # => returns 2

johnny_cache.add([1, 2, 3])
 # => cache: "I walk the line", 5, [1, 2, 3]  size = 3

johnny_cache.add(5)
 # => cache: "I walk the line", [1, 2, 3], 5    size = 3

johnny_cache.add(-5)
 #  => cache: "I walk the line", [1, 2, 3], 5, -5    size = 4

johnny_cache.add({a: 1, b: 2, c: 3})
 # => cache: [1, 2, 3], 5, -5, {a: 1, b: 2, c: 3}     size = 4

johnny_cache.add([1, 2, 3, 4])
 # => cache: 5, -5, {a: 1, b: 2, c: 3}, [1, 2, 3, 4]  size = 4

johnny_cache.add("I walk the line")
 # => cache: -5, {a: 1, b: 2, c: 3}, [1, 2, 3, 4] , "I walk the line"   size = 4

johnny_cache.add(:ring_of_fire)
 # => cache: {a: 1, b: 2, c: 3}, [1, 2, 3, 4], "I walk the line", :ring_of_fire   size = 4

johnny_cache.add("I walk the line")
 # => cache: {a: 1, b: 2, c: 3}, [1, 2, 3, 4], :ring_of_fire, "I walk the line"

johnny_cache.add({a: 1, b: 2, c: 3})
 # => cache: [1, 2, 3, 4], :ring_of_fire, "I walk the line", {a: 1, b: 2, c: 3}

johnny_cache.show
# [1, 2, 3, 4], :ring_of_fire, "I walk the line", {a: 1, b: 2, c: 3}
