class Node
  attr_accessor :key, :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end

  def remove
    # optional but useful, connects previous link to next link
    # and removes self from list.

    if self.prev
      self.prev.next = self.next
    end

    if self.next
      self.next.prev = self.prev
    end

    @next = nil
    @prev = nil
  end
end

class LinkedList
  include Enumerable

  attr_accessor :head, :tail
  def initialize
    @head = Node.new
    @tail = Node.new
    @head.next = @tail
    @tail.prev = @head
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    @head.next
  end

  def last
    @tail.prev
  end

  def empty?
    @head.next == @tail
  end

  def get(key)
    if include?(key)
      current_node = @head

      while current_node != nil
        return current_node.val if current_node.key == key
        current_node = current_node.next
      end
    else
      nil
    end
  end

  def include?(key)

    self.each do |node|
      return true if node.key == key
    end

    false
  end

  def append(key, val)
    new_node = Node.new(key, val)

    prev_node = @tail.prev
    prev_node.next = new_node
    new_node.prev = prev_node
    new_node.next = @tail
    @tail.prev = new_node


  end

  def update(key, val)
    if include?(key)
      current_node = @head

      current_node = current_node.next until current_node.key == key

      current_node.val = val
    end
  end

  def remove(key)

    if include?(key)
      current_node = @head

      current_node = current_node.next until current_node.key == key
      current_node.remove

    else
      nil
    end

  end

  def each
    current_node = @head.next

    while current_node != @tail
      yield current_node
      current_node = current_node.next
    end

  end

  # uncomment when you have `each` working and `Enumerable` included
  # def to_s
  #   inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  # end
end
