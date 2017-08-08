class Queue

  def initialize
    @queue = []
    @size = 0
  end

  def enqueue(el)
    @size += 1
    @queue << el
  end

  def dequeue
    @queue.shift
  end

  def show
    @queue.dup
  end

  def size
    @size
  end
end


queue = Queue.new
queue.enqueue(1)
queue.enqueue(2)
queue.enqueue(3)
queue.enqueue(4)

p queue.show
p queue.dequeue
p queue.dequeue
p queue.show
