require 'byebug'

class Array

  # Monkey patch the Array class and add a my_inject method. If my_inject receives
  # no argument, then use the first element of the array as the default accumulator.

  def my_inject(accumulator = nil, &prc)
    prc ||= Proc.new { |x, y| x <=> y }

    i = 0
    if accumulator.nil?
      accumulator = self.first
      i = 1
    end

    self[i..-1].each do |el|
      accumulator = prc.call(accumulator, el)
    end

    accumulator
  end
end
