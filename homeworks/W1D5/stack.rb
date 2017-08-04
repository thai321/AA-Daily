class Stack
  def initialize
    @stack = []
    @size = 0
  end

  def add(el)
    @stack << el
    @size +=1
  end

  def remove
    @size -= 1
    @stack.pop
  end

  def show
    @stack.dup
  end
end

stack = Stack.new
stack.add(1)
stack.add(2)
stack.add(3)
stack.add(4)

p stack.show
p stack.remove
p stack.remove
p stack.show
