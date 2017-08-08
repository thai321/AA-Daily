class Title
  attr_accessor :value
  def initialize(value)
    @value = value
  end

  def []()
    @value
  end

  def []=(value)
    @value = value
  end

  def to_s
    @value.to_s
  end
end
