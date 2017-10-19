class BinaryMinHeap
  attr_reader :store, :prc

  def initialize(&prc)
    @prc ||= Proc.new { |x,y| x <=> y }
    @store = []
  end

  def count
    @store.length
  end

  def extract
    @store[0], @store[count - 1] = @store[count - 1], @store[0]
    result = @store.pop
    BinaryMinHeap.heapify_down(@store, 0, &@prc)
    result
  end

  def peek
    @store[0]
  end

  def push(val)
    @store.push(val)
    BinaryMinHeap.heapify_up(@store, count - 1, &@prc)
  end

  public
  def self.child_indices(len, parent_index)
    left_index = 2*parent_index + 1
    right_index = 2*parent_index + 2
    [left_index, right_index].select { |n| n < len }
  end

  def self.parent_index(child_index)
    raise "root has no parent" if child_index == 0
    (child_index - 1) / 2
  end

  def self.heapify_down(array, parent_idx, len = array.length, &prc)
    prc ||= Proc.new { |x,y| x <=> y}
    parent = array[parent_idx]

    children_idxs = child_indices(len, parent_idx)
    children = children_idxs.map { |idx| array[idx] }

    return array if children.all? { |el| prc.call(parent, el) <=0 }

    smaller_child_idx = children_idxs[0] # left children index

    if children_idxs.length == 2 && prc.call(children[0], children[1]) > - 1
      smaller_child_idx = children_idxs[1] # right children index
    end

    array[smaller_child_idx], array[parent_idx] = parent, array[smaller_child_idx]

    heapify_down(array, smaller_child_idx, len, &prc)
  end

  def self.heapify_up(array, child_idx, len = array.length, &prc)
    return array if child_idx == 0

    prc ||= Proc.new { |a, b| a <=> b }
    child = array[child_idx]
    parent_idx = parent_index(child_idx)
    parent = array[parent_idx]

    if prc.call(child, parent) < 0
      array[parent_idx], array[child_idx] = child, parent
      heapify_up(array, parent_idx, len, &prc)
    else
      return array
    end
  end
end
