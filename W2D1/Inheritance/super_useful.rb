# PHASE 2
def convert_to_int(str)
  begin
    num = Integer(str)
  rescue ArgumentError => e
    puts "Error: #{e}"
  ensure
    num ||= nil
  end

  num
end

# PHASE 3
class CoffeeError < StandardError
  def message
    puts "Coffee is not a fruit, but I like coffee."
  end
end

class NotAFruitError < StandardError
  def message
    puts "I don't like that fruit."
  end
end

FRUITS = ["apple", "banana", "orange"]

def reaction(maybe_fruit)
  if FRUITS.include? maybe_fruit
    puts "OMG, thanks so much for the #{maybe_fruit}!"
  elsif maybe_fruit == "coffee"
    raise CoffeeError
  else
    raise NotAFruitError
  end
end

def feed_me_a_fruit
  puts "Hello, I am a friendly monster. :)"

  begin
    puts "Feed me a fruit! (Enter the name of a fruit:)"
    maybe_fruit = gets.chomp
    reaction(maybe_fruit)
  rescue CoffeeError => e
    puts e.message
    retry
  rescue NotAFruitError => e
    puts e.message
  end
end

# PHASE 4
class BestFriend
  def initialize(name, yrs_known, fav_pastime)
    raise ArgumentError.new("years can't be less than 5") if yrs_known < 5
    raise ArgumentError.new("Name can't be empty") if name.length <= 0
    raise ArgumentError.new("Favorite pastime can't be empty") if fav_pastime.length <= 0

    @name = name
    @yrs_known = yrs_known
    @fav_pastime = fav_pastime
  end

  def talk_about_friendship
    puts "Wowza, we've been friends for #{@yrs_known}.
    Let's be friends for another #{1000 * @yrs_known}."
  end

  def do_friendstuff
    puts "Hey bestie, let's go #{@fav_pastime}.
    Wait, why don't you choose. 😄"
  end

  def give_friendship_bracelet
    puts "Hey bestie, I made you a friendship bracelet.
    It says my name, #{@name}, so you never forget me."
  end
end
