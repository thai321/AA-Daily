class Array

  def my_any?(&prc)
    prc ||= Proc.new { |x, y| x <=> y }

    self.each { |el| return true if prc.call(el) }
    false
  end

end
