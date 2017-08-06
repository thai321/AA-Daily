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
------
## Digital Root
```ruby
# Write a method, `digital_root(num)`. It should Sum the digits of a positive
# integer. If it is greater than 10, sum the digits of the resulting number.
# Keep repeating until there is only one digit in the result, called the
# "digital root". **Do not use string conversion within your method.**
#
# You may wish to use a helper function, `digital_root_step(num)` which performs
# one step of the process.

def digital_root(num)
  return num if num < 10

  num = digital_root_step(num)

  (num > 10) ? digital_root(num) : num
end

def digital_root_step(num)
  sum = 0

  until num == 0
    sum += num %10
    num = num / 10
  end

  sum
end


describe "#digital_root" do
  it "calculates the digital root of a single-digit number" do
    expect(digital_root(9)).to eq(9)
  end

  it "calculates the digital root of a larger number" do
    expect(digital_root(4322)).to eq(2)
  end

  it "does not call #to_s on the argument" do
    expect_any_instance_of(Fixnum).to_not receive(:to_s)
    digital_root(4322)
  end
end
```
-----
### Doubler
```ruby
# Write a method that doubles each element in an array
def doubler(array)
  array.map { |e| 2 * e  }
end

describe "#doubler" do
  let(:array) { [1, 2, 3] }

  it "doubles the elements of the array" do
    expect(doubler(array)).to eq([2, 4, 6])
  end

  it "does not modify the original array" do
    duped_array = array.dup

    doubler(array)

    expect(array).to eq(duped_array)
  end
end
```
-------
### Dups
```ruby
class Array

  # Write an Array#dups method that will return a hash containing the indices of all
  # duplicate elements. The keys are the duplicate elements; the values are
  # arrays of their indices in ascending order, e.g.
  # [1, 3, 4, 3, 0, 3, 0].dups => { 3 => [1, 3, 5], 0 => [4, 6] }

  def dups
    hash = Hash.new { |h, k| h[k] = [] }

    self.each_with_index { |e, i| hash[e] << i }

    hash.select { |_, v| v.length > 1 }
  end
end


describe "#dups" do
  it "solves a simple example" do
    expect([1, 3, 0, 1].dups).to eq({ 1 => [0, 3] })
  end

  it "finds two dups" do
    expect([1, 3, 0, 3, 1].dups).to eq({ 1 => [0, 4], 3 => [1, 3] })
  end

  it "finds multi-dups" do
    expect([1, 3, 4, 3, 0, 3].dups).to eq({ 3 => [1, 3, 5] })
  end

  it "returns {} when no dups found" do
    expect([1, 3, 4, 5].dups).to eq({})
  end
end
```

-----
### Factorial Recursive

```ruby
# Write a recursive method that returns the first "num" factorial numbers.
# Note that the 1st factorial number is 0!, which equals 1. The 2nd factorial
# is 1!, the 3rd factorial is 2!, etc.

def factorials_rec(num)
  return [1] if num == 1
  return [1, 1] if num == 2

  arr += factorials_rec(num - 1)
  arr << (num - 1) * arr.last
end

describe "#factorials_rec" do
  it "returns first factorial number" do
    expect(factorials_rec(1)).to eq([1])
  end

  it "returns first two factorial numbers" do
    expect(factorials_rec(2)).to eq([1, 1]) # = [0!, 1!]
  end

  it "returns many factorials numbers" do
    expect(factorials_rec(6)).to eq([1, 1, 2, 6, 24, 120])
    # == [0!, 1!, 2!, 3!, 4!, 5!]
  end

  it "calls itself recursively" do
    # this should enforce you calling your method recursively.

    expect(self).to receive(:factorials_rec).at_least(:twice).and_call_original
    factorials_rec(6)
  end
end
```
### Factors

```ruby
# Write a method that returns the factors of a number in ascending order.

def factors(num)
  return 1 if num == 1

  (1..num).select { |n| (num % n) == 0 }
end

describe "#factors" do
  it "returns the factors of 10 in order" do
    expect(factors(10)).to eq([1, 2, 5, 10])
  end

  it "returns just two factors for primes" do
    expect(factors(13)).to eq([1, 13])
  end
end
```

-----
### Fibonacci Sum Recursive

```ruby
# Implement a method that finds the sum of the first n
# fibonacci numbers recursively. Assume n > 0
def fibs_sum(n)
  return 1 if n == 1
  return 2 if n == 2

  current = single_fib(n)
  current += fibs_sum(n - 1)
end

def single_fib(n)
  return 1 if n == 1
  return 1 if n == 2

  single_fib(n - 1) + single_fib(n - 2)
end

# solution
def fibs_sum(n)
  return 0 if n == 0
  return 1 if n == 1

  fibs_sum(n-1) + fibs_sum(n-2) + 1
end

describe 'fibs_sum' do

  it 'It correctly gets the answer for the 1st fibonacci number' do
    expect(fibs_sum(1)).to eq(1)
  end

  it 'It correctly gets the answer for the first 2 fibonacci numbers' do
    expect(fibs_sum(2)).to eq(2)
  end

  it 'It correctly gets the answer for the first 6 fibonacci numbers' do
    expect(fibs_sum(6)).to eq(20)
  end

end
```

------

### Jumble Sort
```ruby

# Jumble sort takes a string and an alphabet. It returns a copy of the string
# with the letters re-ordered according to their positions in the alphabet. If
# no alphabet is passed in, it defaults to normal alphabetical order (a-z).

# Example:
# jumble_sort("hello") => "ehllo"
# jumble_sort("hello", ['o', 'l', 'h', 'e']) => 'ollhe'

def jumble_sort(str, alphabet = nil)
  return str.chars.sort.join if alphabet.nil?

  arr = []
  i = 0
  alphabet.each do |char|
    break if i >= str.length

    if str.include?(char) && !arr.include?(char)
      count = str.count(char)
      arr << char * count
      i += count
    end
  end

  arr.join
end

describe "#jumble_sort" do
  it "defaults to alphabetical order" do
    expect(jumble_sort("hello")).to eq("ehllo")
  end

  it "takes an alphabet array and sorts by that order" do
    alph = ("a".."z").to_a
    hello = "hello".chars.uniq
    alph -= hello
    alphabet = (hello += alph)

    expect(jumble_sort("hello", alphabet)).to eq("hello")
  end

  it "sorts by a reversed alphabet" do
    reverse = ("a".."z").to_a.reverse
    expect(jumble_sort("hello", reverse)).to eq("ollhe")
  end
end
```

------
### Make Better Change
```ruby
# make better change problem from class
# make_better_change(24, [10,7,1]) should return [10,7,7]
# make change with the fewest number of coins

# To make_better_change, we only take one coin at a time and
# never rule out denominations that we've already used.
# This allows each coin to be available each time we get a new remainder.
# By iterating over the denominations and continuing to search
# for the best change, we assure that we test for 'non-greedy' uses
# of each denomination.

def make_better_change(value, coins)
  return [value] if coins.include?(value)
  return [] if value <= 0

  possible_changes = []

  coins.each do |coin|
    if value >= coin
      changes = [coin] + make_better_change(value - coin, coins)
      possible_changes << changes
    end
  end

  return [] if possible_changes.empty?
  possible_changes.min_by(&:length)
end


describe "Make better change" do
  it "Returns the smallest possible array of coins: case 1" do
    expect(make_better_change(24, [10,7,1])).to eq([10,7,7])
  end

  it "Returns the smallest possible array of coins: case 2" do
    expect(make_better_change(25, [10,7,1])).to eq([10,7,7,1])
  end

  it "Returns the smallest possible array of coins: case 3" do
    expect(make_better_change(25, [10,8,7,1])).to eq([10,8,7])
  end
end
```

------
### Median
```ruby
# Write a method that returns the median of elements in an array
# If the length is even, return the average of the middle two elements
class Array
  def median
    return nil if self.empty?
    return self[0] if self.length == 1
    copy = self.sort

    mid = copy.length / 2
    copy.length.even? ? (copy[mid-1] + copy[mid])/2.0 : copy[mid]
  end
end


describe "#median" do
  let(:even_array) { [3, 2, 6, 7] }
  let(:odd_array) { [3, 2, 6, 7, 1] }

  it "returns nil for the empty array" do
    expect([].median).to be_nil
  end

  it "returns the element for an array of length 1" do
    expect([1].median).to eq(1)
  end

  it "returns the median of an odd-length array" do
    expect(odd_array.median).to eq(3)
  end

  it "returns the median of an even-length array" do
    expect(even_array.median).to eq(4.5)
  end
end
```

------
### Merge Sort

```ruby
class Array

  # Write an Array#merge_sort method; it should not modify the original array.

  def merge_sort(&prc)
    prc ||= Proc.new { |x, y| x <=> y }

    return self if self.length <= 1

    mid = self.length / 2

    left = self[0...mid].merge_sort(&prc)
    right = self[mid..-1].merge_sort(&prc)

    Array.merge(left, right, &prc)
  end

  private
  def self.merge(left, right, &prc)
    i, j = 0, 0
    new_arr = []
    while i < left.length && j < right.length
      if prc.call(left[i], right[j]) == -1
        new_arr << left[i]
        i += 1
      else
        new_arr << right[j]
        j += 1
      end
    end

    new_arr.concat(left[i..-1] + right[j..-1])
    new_arr
  end
end

describe "#merge_sort" do
  let(:array) { [1, 2, 3, 4, 5].shuffle }

  it "works with an empty array" do
    expect([].merge_sort).to eq([])
  end

  it "works with an array of one item" do
    expect([1].merge_sort).to eq([1])
  end

  it "sorts numbers" do
    expect(array.merge_sort).to eq(array.sort)
  end

  it "will use block if given" do
    reversed = array.merge_sort do |num1, num2|
      # reverse order
      num2 <=> num1
    end
    expect(reversed).to eq([5, 4, 3, 2, 1])
  end

  it "does not modify original" do
    duped_array = array.dup
    duped_array.merge_sort
    expect(duped_array).to eq(array)
  end

  it "calls the merge helper method" do
    expect(Array).to receive(:merge).at_least(:once).and_call_original
    array.merge_sort
  end
end
```
