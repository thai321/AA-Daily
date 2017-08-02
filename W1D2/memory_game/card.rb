class Card
  attr_reader :value
  attr_accessor :face_up
  def initialize(value)
    @value = value
    @face_up = false
  end

  def hide
    @face_up = false
  end

  def reveal
    @face_up = true
  end

  def to_s
    @value.to_s
  end

  def ==(card)
    @value == card.value
  end
end
