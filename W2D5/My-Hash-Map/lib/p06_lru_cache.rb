require_relative 'p05_hash_map'
require_relative 'p04_linked_list'

class LRUCache
  attr_reader :count
  def initialize(max, prc)
    @map = HashMap.new
    @store = LinkedList.new
    @max = max
    @prc = prc
  end

  def count
    @map.count
  end

  def get(key)
    if @map.include?(key)
      node = @map[key]
      update_node!(node)
    else
      calc!(key)
    end

    @map.get(key).val
  end

  def to_s
    "Map: " + @map.to_s + "\n" + "Store: " + @store.to_s
  end

  private

  def calc!(key)
    # suggested helper method; insert an (un-cached) key
    eject! if count == @max
    new_value = @prc.call(key)
    new_node = @store.append(key, new_value)
    @map.set(key, new_node)

    new_value
  end

  def update_node!(node)
    # suggested helper method; move a node to the end of the list
    node = node.remove
    @map[node.key] = @store.append(node.key, node.val)
  end

  def eject!
    oldest_node = @store.first
    oldest_node = oldest_node.remove

    @map.delete(oldest_node.key)
  end
end
