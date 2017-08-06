## Assessment1 practice
- From
https://github.com/mallorybulkley/aa-practice-test-generator

------
### Binary Search
```ruby
class Array

  # Write a monkey patch of binary search:
  # E.g. [1, 2, 3, 4, 5, 7].my_bsearch(5) => 4
  def my_bsearch(target, &prc)
    prc ||= Proc.new { |x, y| x <=> y }
    if self.length == 1 and prc.call(self[0], target) != 0
      return nil
    end

    mid = self.length/2
    if prc.call(self[mid], target) == 0
      return mid
    elsif prc.call(self[mid], target) == 1
      self[0...mid].my_bsearch(target, &prc)
    else # -1
      bsearch = self[(mid + 1)..-1].my_bsearch(target, &prc)
      if !bsearch.nil?
        mid + 1 + bsearch
      end
    end
  end
end

p [1,2,3].my_bsearch(1) == 0
p [2, 3, 4, 5].my_bsearch(3) == 1
p [2, 4, 6, 8, 10].my_bsearch(6) == 2
p [1, 3, 4, 5, 9].my_bsearch(5) == 3
p [1, 2, 3, 4, 5, 6].my_bsearch(6) == 5
p [1, 2, 3, 4, 5, 6].my_bsearch(0) == nil
p [1, 2, 3, 4, 5, 7].my_bsearch(6) == nil
```
------

### Bubble Sort
```ruby
class Array
  # without prc
  def bubble_sort!
    return self if self.length <= 1

    (self.length - 1).downto(1) do |i|
      0.upto(i - 1) do |j|
        if self[j] > self[j + 1]
          self[j], self[j + 1] = self[j + 1], self[j]
        end
      end
    end
    self
  end

  # with proc
  def bubble_sort!(&prc)
    prc ||= Proc.new { |x, y| x <=> y }
    return self if self.length <= 1

    (self.length - 1).downto(1) do |i|
      0.upto(i - 1) do |j|
        if prc.call(self[j], self[j + 1]) == 1
          self[j], self[j + 1] = self[j + 1], self[j]
        end
      end
    end
    self
  end

  def bubble_sort(&prc)
    self.dup.bubble_sort!
  end
end

describe "#bubble_sort!" do
  let(:array) { [1, 2, 3, 4, 5].shuffle }

  it "works with an empty array" do
    expect([].bubble_sort!).to eq([])
  end

  it "works with an array of one item" do
    expect([1].bubble_sort!).to eq([1])
  end

  it "sorts numbers" do
    expect(array.bubble_sort!).to eq(array.sort)
  end

  it "modifies the original array" do
    duped_array = array.dup
    array.bubble_sort!
    expect(duped_array).not_to eq(array)
  end

  it "will use a block if given" do
    sorted = array.bubble_sort! do |num1, num2|
      # order numbers based on descending sort of their squares
      num2**2 <=> num1**2
    end

    expect(sorted).to eq([5, 4, 3, 2, 1])
  end
end

describe "#bubble_sort" do
  let(:array) { [1, 2, 3, 4, 5].shuffle }

  it "delegates to #bubble_sort!" do
    expect_any_instance_of(Array).to receive(:bubble_sort!)

    array.bubble_sort
  end

  it "does not modify the original array" do
    duped_array = array.dup
    array.bubble_sort
    expect(duped_array).to eq(array)
  end
end

```

-----
### Caesar Cipher
```ruby
# Back in the good old days, you used to be able to write a darn near
# uncrackable code by simply taking each letter of a message and incrementing it
# by a fixed number, so "abc" by 2 would look like "cde", wrapping around back
# to "a" when you pass "z".  Write a function, `caesar_cipher(str, shift)` which
# will take a message and an increment amount and outputs the encoded message.
# Assume lowercase and no punctuation. Preserve spaces.
#
# To get an array of letters "a" to "z", you may use `("a".."z").to_a`. To find
# the position of a letter in the array, you may use `Array#find_index`.

def caesar_cipher(str, shift)
  alphabet = ('a'..'z').to_a
  new_str = ''

  str.chars.each do |char|
    index = alphabet.find_index(char)
    if index
      new_str << alphabet[(index + shift) % alphabet.length]
    else
      new_str << char
    end
  end
  new_str
end


describe "#caesar_cipher" do
  it "encodes a simple word" do
    expect(caesar_cipher("aaa", 11)).to eq("lll")
  end

  it "wraps around the alphabet" do
    expect(caesar_cipher("zzz", 1)).to eq("aaa")
  end

  it "encodes multiple words" do
    expect(caesar_cipher("catz hatz", 2)).to eq("ecvb jcvb")
  end
end
```
------
### Deep Dup
```ruby
# Using recursion and the is_a? method,
# write an Array#deep_dup method that will perform a "deep" duplication of the interior arrays.

def deep_dup(arr)
  arr.map do |el|
    if el.is_a? Array
      deep_dup(el)
    else
      el
    end
  end
end

describe "deep_dup" do
  robot_parts = [
  ["nuts", "bolts", "washers"],
  ["capacitors", "resistors", "inductors"]
  ]

  copy = deep_dup(robot_parts)

  it "makes a copy of the original array" do
    expect(copy).to eq(robot_parts)
  end

  it "deeply copies arrays" do
    copy[1] << "LEDs"
    expect(robot_parts[1]).to eq(["capacitors", "resistors", "inductors"])
  end
end
```

-----
### Exponent
```ruby
# return b^n recursively. Your solution should accept negative values
# for n
def exponent(b, n)
  return 1 if n == 0

  if n > 0
    b * exponent(b, n - 1)
  else
    (1.0 / b) * exponent(b, n + 1)
  end
end

describe "exponent" do
  it "correctly handles positive powers" do
    expect(exponent(5,3)).to eq(125)
  end

  it "correctly handles negative powers" do
    expect(exponent(2, -3)).to eq(1/8.0)
  end

  it "correctly handles 0" do
    expect(exponent(2, 0)).to eq(1)
  end
end
```

-----
### First Even Number
```ruby
# return the sum of the first n even numbers recursively. Assume n > 0
def first_even_numbers_sum(n)
  return 2 if n == 1

  2 * n + first_even_numbers_sum(n - 1)
end

describe 'first_even_numbers_sum' do

  it "Correctly returns the sum of the first even number" do
    expect(first_even_numbers_sum(1)).to eq(2)
  end

  it "Returns the sum of the first n even numbers" do
    expect(first_even_numbers_sum(6)).to eq(42)
  end

end
```

------
### Quick Sort

```ruby
class Array

  #Write a monkey patch of quick sort that accepts a block
  def my_quick_sort(&prc)
    prc ||= Proc.new { |x, y| x <=> y }

    return self if self.length < 1

    pivot = self.first

    left = self[1..-1].select { |n| prc.call(n, pivot) == -1 }
    right = self[1..-1].select { |n| prc.call(n,pivot) != -1 }

    left.my_quick_sort(&prc) + [pivot] + right.my_quick_sort(&prc)
  end
end

describe "my_quick_sort" do

  a = (0..8).to_a

  it "Sorts an array of numbers with no duplicates" do
    expect(a.shuffle.my_quick_sort).to eq(a)
  end

  it "Sorts an array of numbers with duplicates" do
    expect([1,2,3,3,9,10,10,17,432].shuffle.my_quick_sort).to eq([1,2,3,3,9,10,10,17,432])
  end

  it "Sorts according to the block passed in" do
    expect(a.shuffle.my_quick_sort{|a,b| b<=>a}).to eq(a.reverse)
  end
end
```
