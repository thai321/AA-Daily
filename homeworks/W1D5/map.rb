# Map
class Map
  def initialize
    @map = []
  end

  def assign(key, value)
    index = @map.index { |k, v| k == key }
    if index
      @map[index][1] = value
    else
      @map << [key, value]
    end
    [key, value]
  end

  def lookup(key)
    @map.each { |k, v| return v if k == key }
  end

  def remove(key)
    @map.delete_if { |k, v| k == key }
  end

  def show
    @map.dup
  end
end

my_map = Map.new
my_map.assign(1, 'a')
my_map.assign(2, 'b')
my_map.assign(3, 'c')
my_map.assign(4, 'd')
my_map.assign(1, 'z')


p my_map.show
puts "Look up 3: #{my_map.lookup(3)}"
p my_map.remove(2)
p my_map.remove(4)
p my_map.show
