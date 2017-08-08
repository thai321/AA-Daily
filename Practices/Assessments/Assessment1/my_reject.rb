class Array

  def my_reject(&prc)
    prc ||= Proc.new { |x, y| x <=> y }

    self.select { |el|  !prc.call(el) }
  end

end
