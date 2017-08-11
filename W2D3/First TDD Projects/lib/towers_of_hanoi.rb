class Game
  TOWER_SIZE = 3
  attr_accessor :tower

  def initialize
    @tower = [ [3, 2, 1], [], [] ]
  end

  def move(from, to)
    disc = @tower[from].pop
    tower[to].push(disc)
  end

  def won?
    @tower[1] == [3 ,2, 1] || @tower[2] == [3, 2, 1]
  end

  def display
    (0...3).each do |i|
      puts "tower #{i}: #{tower[i]}"
    end
  end

  def get_input
    puts "Enter a from index"
    from = gets.chomp.to_i

    puts "Enter a to index"
    to = gets.chomp.to_i

    [from, to]
  end

  def round
    display
    pos = get_input
    move(pos[0], pos[1])
  end

  def play
    puts "Welcome to the game"
    round until won?
    puts "Done"
  end
end

# game = Game.new
# game.play
