class HumanPlayer
  attr_reader :name
  attr_accessor :score

  def initialize(name)
    @name = name
    @score = 0
  end

  def guess
    prompt
    ans = gets.chomp
    [ans[0].to_i, ans[-1].to_i]
  end

  def prompt
    puts "#{self}'s turn'"
    puts 'Please enter a position in this format (1, 1).'
  end

  def to_s
    @name
  end

end
