class MyStack
  def initialize(store=[])
    @store = store
  end

  def pop
    @store.pop
  end

  def push(val)
    @store.push(val)
  end

  def peek
    @store[-1]
  end

  def size
    @store.size
  end

  def empty?
    @store.empty?
  end


  def show
    @store.each do |el|
      print " #{el}, "
    end
  end
end
