class Array

  def my_join(str = "")
    new_str = ""

    self[0...-1].each { |char| new_str << char + str }

    new_str + self.last
  end

end
