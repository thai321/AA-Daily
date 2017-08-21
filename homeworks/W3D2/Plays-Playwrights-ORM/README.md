# LRU Cache

Tonight we're going to implement a basic [LRU Cache][lru-cache] using an array.  We will assume our input is limited to Fixnums, Strings, Arrays, Symbols, and Hashes. We will allow the user to set the size of the cache.

[lru-cache]: http://mcicpc.cs.atu.edu/archives/2012/mcpc2012/lru/lru.html

Ultimately, our LRU Cache should function as follows:

```ruby
  johnny_cache = LRUCache.new(4)

  johnny_cache.add("I walk the line")
  johnny_cache.add(5)

  johnny_cache.count # => returns 2

  johnny_cache.add([1,2,3])
  johnny_cache.add(5)
  johnny_cache.add(-5)
  johnny_cache.add({a: 1, b: 2, c: 3})
  johnny_cache.add([1,2,3,4])
  johnny_cache.add("I walk the line")
  johnny_cache.add(:ring_of_fire)
  johnny_cache.add("I walk the line")
  johnny_cache.add({a: 1, b: 2, c: 3})


  johnny_cache.show # => prints [[1, 2, 3, 4], :ring_of_fire, "I walk the line", {:a=>1, :b=>2, :c=>3}]
```

Use the below framework to get started.

```ruby
  class LRUCache
    def initialize
    end

    def count
      # returns number of elements currently in cache
    end

    def add(el)
      # adds element to cache according to LRU principle
    end

    def show
      # shows the items in the cache, with the LRU item first
    end

    private
    # helper methods go here!

  end
```

Once you have written your code, thoroughly test it to make sure it truly is an LRU Cache.

After you finish, or if you get stuck in the process, you can view the solutions [here][lru-cache-solutions].

[lru-cache-solutions]: solution.rb

## Time Complexity

As you might have guessed, this is not the typical implementation of an LRU Cache.  Any thoughts as to why?

Let's consider the time complexity of the `LRUCache#add` method you wrote.  In my solution it's `O(n)`, where n is the size of the cache.  For a large cache, that's a very lengthy process for simply adding one element.  How might we improve the efficiency?  Brainstorm some ways we might apply the ADTs from tonight's readings to do this.

## Bonus!

Write specs to test that your implementation works!  
