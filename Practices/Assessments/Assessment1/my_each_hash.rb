class Hash

  # Write a version of my each that calls a proc on each key, value pair
  def my_each(&prc)
    prc ||= Proc.new { |x, y| x <=> y }

    self.keys.each do |k|
      prc.call(k, self[k])
    end
  end

end
