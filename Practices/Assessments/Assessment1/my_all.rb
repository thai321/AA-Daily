class Array

  def my_all?(&prc)
    prc ||= Proc.new { |x, y| x <=> y }

    if ( self.any? { |e| !prc.call(e) } )
      return false
    end
    true
  end
end
