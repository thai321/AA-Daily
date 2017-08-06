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
-------
### My All
```ruby
class Array

  def my_all?(&prc)
    prc ||= Proc.new { |x, y| x <=> y }

    if ( self.any? { |e| !prc.call(e) } )
      return false
    end
    true
  end
end

describe 'my_all' do
  a= [1,2,3]

  it "returns true if all elements match the block" do
    expect(a.my_all? { |num| num > 0 }).to eq(true)
  end

  it "returns false if not all elementes match the block" do
    expect(a.my_all? { |num| num > 1 }).to eq(false)
  end
end
```
------
### My Any
```ruby
class Array

  def my_any?(&prc)
    prc ||= Proc.new { |x, y| x <=> y }

    self.each { |el| return true if prc.call(el) }
    false
  end

end

describe 'my_any' do
  a= [1,2,3]
  it "returns true if any number matches the block" do
    expect(a.my_any? { |num| num > 1 }).to eq(true)
  end

  it "returns false if no elementes match the block" do
    expect(a.my_any? { |num| num == 4 }).to eq(false)
  end
end
```
------
### My Each Hash
```ruby
class Hash

  # Write a version of my each that calls a proc on each key, value pair
  def my_each(&prc)
    prc ||= Proc.new { |x, y| x <=> y }

    self.keys.each do |k|
      prc.call(k, self[k])
    end
  end

end

describe "my_each" do
  a = {"a"=> 1, "b" => 2, "c" => 3}
  res = ""
  a.my_each{|key, v| v.times{res << key}}

  it "Calls the proc on each key value pair" do
    expect(res.chars.sort).to eq(["a","b","b","c","c","c"])
  end
end
```
------
### My Each and My Each with Index

```ruby
class Array

  def my_each(&prc)
    prc ||= Proc.new { |x, y|  x <=> y }

    self.length.times { |i| prc.call(self[i]) }
  end

  def my_each_with_index(&prc)
    prc ||= Proc.new { |x, y| x <=> y }

    self.length.times { |i| prc.call(self[i], i) }
  end

end

describe "my_each" do
  res = []
  [1,2,3].my_each{|el| res << 2*el}

  it "It works for blocks" do
    expect(res).to eq([2,4,6])
  end
end

describe "my_each_with_index" do
  res = []
  [1,2,3].my_each_with_index{|el, i| res << 2*el + i}

  it "It works for blocks that use both the index and element" do
    expect(res).to eq([2,5,8])
  end
end
```

-----
### My Flatten

```ruby
require 'byebug'

class Array

  # Takes a multi-dimentional array and returns a single array of all the elements
  # [1,[2,3], [4,[5]]].my_controlled_flatten(1) => [1,2,3,4,5]
  def my_flatten
    arr = []

    self.each do |el|
      if el.is_a? Array
        arr += el.my_flatten
      else
        arr << el
      end
    end

    arr
  end

  # Write a version of flatten that only flattens n levels of an array.
  # E.g. If you have an array with 3 levels of nested arrays, and run
  # my_flatten(1), you should return an array with 2 levels of nested
  # arrays
  #
  # [1,[2,3], [4,[5]]].my_controlled_flatten(1) => [1,2,3,4,[5]]
  def my_controlled_flatten(n)
    return self if n <= 0

    arr = []

    self.each do |el|
      if (el.is_a? Array) && n > 0
        arr += el.my_controlled_flatten(n - 1)
      else
        arr << el
      end
    end

    arr
  end
end

describe "my_flatten" do
  it 'Flattens arrays correctly' do
    expect([1, 2, 3, [4, [5, 6]], [[[7]], 8]].my_flatten).to eq([1, 2, 3, 4, 5, 6, 7, 8])
  end
end

describe "my_controlled_flatten" do
  it "Flattens an array the specified number of levels" do
    expect([1,[2,3], [4,[5]], [[6,[7]]]].my_controlled_flatten(1)).to eq([1,2,3,4,[5], [6, [7]]])
  end
end
```
-----
### My Inject
```ruby

class Array

  # Monkey patch the Array class and add a my_inject method. If my_inject receives
  # no argument, then use the first element of the array as the default accumulator.

  def my_inject(accumulator = nil, &prc)
    prc ||= Proc.new { |x, y| x <=> y }

    i = 0
    if accumulator.nil?
      accumulator = self.first
      i = 1
    end

    self[i..-1].each do |el|
      accumulator = prc.call(accumulator, el)
    end

    accumulator
  end
end


describe 'Array#my_inject' do

  it 'calls the block passed to it' do
    expect do |block|
      ["test array"].my_inject(:dummy, &block)
    end.to yield_control.once
  end

  it 'makes the first element the accumulator if no default is given' do
    expect do |block|
      ["el1", "el2", "el3"].my_inject(&block)
    end.to yield_successive_args(["el1", "el2"], [nil, "el3"])
  end

  it 'yields the accumulator and each element to the block' do
    expect do |block|
      [1, 2, 3].my_inject(100, &block)
    end.to yield_successive_args([100, 1], [nil, 2], [nil, 3])
  end

  it 'does NOT call the built in Array#inject or Array#reduce method' do
    original_array = ["original array"]
    expect(original_array).not_to receive(:inject)
    expect(original_array).not_to receive(:reduce)
    original_array.my_inject {}
  end

  it 'with accumulator, it correctly injects and returns answer' do
    expect([1, 2, 3].my_inject(1) { |acc, x| acc + x }).to eq(7)
    # expect([3, 3].my_inject(3) { |acc, x| acc * x }).to eq(27)
  end

  it 'without accumulator, it correctly injects and returns answer' do
    expect([1, 2, 3].my_inject { |acc, x| acc + x }).to eq(6)
    expect([3, 3].my_inject { |acc, x| acc * x }).to eq(9)
  end
end
```

------
### My Join
```ruby
class Array

  def my_join(str = "")
    new_str = ""

    self[0...-1].each { |char| new_str << char + str }

    new_str + self.last
  end

end

describe "my_join" do
  a = [ "a", "b", "c", "d" ]

  it "Joins an array if no argument is passed" do
    expect(a.my_join).to eq("abcd")
  end

  it "Joins an array if an argument is passed" do
    expect(a.my_join("$")).to eq("a$b$c$d")
  end
end
```
-----
### My Merge

```ruby
class Hash

  # Write a version of merge. This should NOT modify the original hash
  def my_merge(hash2)
    h = self.dup

    hash2.each { |k, v| h[k] = v }

    h
  end

end

describe "my_merge" do
  a = {a: 1, b: 2, c: 3}
  b = {d: 4, e: 5}
  c = {c: 33, d: 4, e: 5}

  it "Merges 2 hashes and returns a hash" do
      expect(a.my_merge(b)).to eq(a.merge(b))
  end

  it "Priortizes values from the hash being merged in" do
      expect(a.my_merge(c)).to eq(a.merge(c))
  end
end
```

-----
### My Reject
```ruby
class Array

  def my_reject(&prc)
    prc ||= Proc.new { |x, y| x <=> y }

    self.select { |el|  !prc.call(el) }
  end

end

describe 'my_reject' do

  a = [1, 2, 3]

  it 'It correctly selects elements that do not match the passed in block' do
    expect(a.my_reject { |num| num > 1 }).to eq([1])
  end

  it 'It returns all elements if no elements match the block' do
    expect(a.my_reject { |num| num == 4 }).to eq([1,2,3])
  end

end
```

-----
### My Reverse
```ruby
class Array

  def my_reverse
    return self if self.length == 1

    self[1..-1].my_reverse.concat([self[0]])
  end

end

describe "my_reverse" do
  a = [ "a", "b", "c", "d" ]

  it "Reverses an array" do
    expect(a.my_reverse).to eq(a.reverse)
  end
end
```

------
### My Rotate

```ruby
class Array

  def my_rotate(num=1)
    num = num % self.length
    self[num..-1] + self[0...num]
  end

end

describe "my_rotate" do
  a = [ "a", "b", "c", "d" ]

  it "Rotates the elements 1 position if no argument is passed in" do
    expect(a.my_rotate).to eq(["b", "c", "d", "a"])
  end

  it "Rotates the elements correctly if an argument is passed in" do
    expect(a.my_rotate(2)).to eq(["c", "d", "a", "b"])
  end

  it "Rotates the elements correctly if a negative argument is passed in" do
    expect(a.my_rotate(-3)).to eq(["b", "c", "d", "a"])
  end

  it "Rotates the elements correctly for a large argument" do
    expect(a.my_rotate(15)).to eq(["d", "a", "b", "c"])
  end

end
```

------
### My Select
```ruby
class Array

  def my_select(&prc)
    arr = []

    self.each { |el| arr << el if prc.call(el) }

    arr
  end

end

describe 'my_select' do

  a = [1, 2, 3]

  it 'It correctly selects elements according to the passed in block' do
    expect(a.my_select { |num| num > 1 }).to eq([2, 3])
  end

  it 'It returns an empty array if there are no matches' do
    expect(a.my_select { |num| num == 4 }).to eq([])
  end

end
```
-----
### My Zip
```ruby
class Array

  def my_zip(*arrs)
    arr = []

    self.each_with_index do |el, i|
      subArr = [el]
      arrs.each { |arr| subArr << arr[i] }
      arr << subArr
    end

    arr
  end

end

describe "my_zip" do
  a = [ 4, 5, 6 ]
  b = [ 7, 8, 9 ]

  it 'Zips arrays of the same size' do
    expect([1, 2, 3].my_zip(a, b)).to eq([[1, 4, 7], [2, 5, 8], [3, 6, 9]])
  end

  it 'Zips arrays of differnet sizes and adds nil appropriately' do
    expect(a.my_zip([1,2], [8])).to eq([[4, 1, 8], [5, 2, nil], [6, nil, nil]])
  end

  c = [10, 11, 12]
  d = [13, 14, 15]

  it "Zips arrays with more elements than the original" do
    expect([1, 2].my_zip(a, b, c, d)).to eq([[1, 4, 7, 10, 13], [2, 5, 8, 11, 14]])
  end

end
```

------
## Permuations
```ruby
# Write a recursive method that returns all of the permutations of an array
def permutations(array)
  return [array]  if array.length == 1

  result = []

  array.each_index do |i|
    subArrays = permutations(array[0...i] + array[(i + 1)..-1])
    result += subArrays.map { |subArr| [array[i]] + subArr  }
  end

  result
end

describe "#permutations" do
  it "returns all permutations of an array" do
    expect(permutations([1, 2, 3])).to eq([[1, 2, 3], [1, 3, 2], [2, 1, 3], [2, 3, 1], [3, 1, 2], [3, 2, 1]])
  end
end
```

-------
### Pig Latinify
```ruby
# Write a method that translates a sentence into pig latin. You may want a helper method.
# 'apple' => 'appleay'
# 'pearl' => 'earlpay'
# 'quick' => 'ickquay'
def pig_latinify(sentence)
  words = sentence.split(' ')
  wordsArr = words.map { |word| translate(word) }
  wordsArr.join(' ')
end

def translate(word)
  vowel = %w(a e i o u qu)
  i = 0
  i += 1 until vowel.include?(word[i])

  i += 1 if (word[i - 1] == 'q')
  word[i..-1] +  word[0...i] + "ay"
end

describe "#pig_latinify" do
  it "translates a word beginning with a vowel" do
    s = pig_latinify("apple")
    expect(s).to eq("appleay")
  end

  it "translates a word beginning with a consonant" do
    s = pig_latinify("banana")
    expect(s).to eq("ananabay")
  end

  it "translates a word beginning with two consonants" do
    s = pig_latinify("cherry")
    expect(s).to eq("errychay")
  end

  it "translates two words" do
    s = pig_latinify("eat pie")
    expect(s).to eq("eatay iepay")
  end

  it "translates a word beginning with three consonants" do
    expect(pig_latinify("three")).to eq("eethray")
  end

  it "counts 'sch' as a single phoneme" do
    s = pig_latinify("school")
    expect(s).to eq("oolschay")
  end

  it "counts 'qu' as a single phoneme" do
    s = pig_latinify("quiet")
    expect(s).to eq("ietquay")
  end

  it "counts 'qu' as a consonant even when it's preceded by a consonant" do
    s = pig_latinify("square")
    expect(s).to eq("aresquay")
  end

  it "translates many words" do
    s = pig_latinify("the quick brown fox")
    expect(s).to eq("ethay ickquay ownbray oxfay")
  end
end
```
-----
### Prime Factorization
```ruby
# Write a recursive function that returns the prime factorization of
# a given number. Assume num > 1
#
# prime_factorization(12) => [2,2,3]
def prime_factorization(num)
  return [] if num == 1
  return [num] if is_prime?(num)

  i = 2
  i += 1 until is_prime?(i) && (num % i) == 0

  arr = [i]
  arr += prime_factorization(num / i)
end

def is_prime?(num)
  return true if num == 2

  (2..Math.sqrt(num)).none? { |n| (num % n) == 0 }
end

describe "prime_factorization" do
  it "handles an input of 2" do
    expect(prime_factorization(2)).to eq([2])
  end

  it "Test case: 12" do
    expect(prime_factorization(12).sort).to eq([2,2,3])
  end

  it "Test case: 600851475143" do
    expect(prime_factorization(600851475143).sort).to eq([71,839,1471,6857])
  end
end
```

----

### Prime
```ruby
# primes(num) returns an array of the first "num" primes.
# You may wish to use an is_prime? helper method.

def is_prime?(num)
  return false if num == 0
  return true if num == 2

  (2..Math.sqrt(num)).none? { |n| (num % n) == 0 }
end

def primes(num)
  return [] if num == 0
  return [2] if num == 1

  arr = [2]
  i = 3
  until (arr.length == num)
    arr << i if is_prime?(i)
    i += 1
  end

  arr
end

describe "#primes" do

  it "returns first five primes in order" do
    expect(primes(5)).to eq([2, 3, 5, 7, 11])
  end

  it "returns an empty array when asked for zero primes" do
    expect(primes(0)).to eq([])
  end
end
```

-----
### Real Words in String
```ruby
class String
  # Returns an array of all the subwords of the string that appear in the
  # dictionary argument. The method does NOT return any duplicates.

  def real_words_in_string(dictionary)
    arr = []

    0.upto(self.length - 1) do |i|
      dictionary.each do |word|
        if !arr.include?(word) && self[i..-1].start_with?(word)
          arr << word
          i += word.length
        end
      end
    end

    arr
  end
end

describe "real_words_in_string" do
  it "finds a simple word" do
    words = "asdfcatqwer".real_words_in_string(["cat", "car"])
    expect(words).to eq(["cat"])
  end

  it "doesn't find words not in the dictionary" do
    words = "batcabtarbrat".real_words_in_string(["cat", "car"])
    expect(words).to be_empty
  end

  it "finds words within words" do
    dictionary = ["bears", "ear", "a", "army"]
    words = "erbearsweatmyajs".real_words_in_string(dictionary)
    expect(words).to eq(["bears", "ear", "a"])
  end
end
```
### Recursive Sum
```ruby
# Write a recursive method that returns the sum of all elements in an array
def rec_sum(nums)
  return 0 if nums.empty?
  return nums[0] if nums.length == 1

  nums[0] + rec_sum(nums[1..-1])
end

describe "#rec_sum" do
  it "returns the sums of all elements in an array" do
    arr = [1,2,3,4]
    expect(rec_sum(arr)).to eq(10)
  end

  it "returns 0 if the array is empty" do
    expect(rec_sum([])).to eq(0)
  end
end
```

### String Include Key
```ruby
require 'byebug'
# Write a recursive method that takes in a string to search and a key string.
# Return true if the string contains all of the characters in the key
# in the same order that they appear in the key.
#
# string_include_key?("cadbpc", "abc") => true
# string_include_key("cba", "abc") => false
def string_include_key?(string, key)
  i = 0
  string.chars.each do |char|
    if key.include?(char) && char != key[i]
      return false
    elsif char == key[i]
      i += 1
    end
  end

  (i == key.length) ? true : false
end

describe "string_include_key" do
  it "returns true for the same string" do
    expect(string_include_key?("adblfci", "abc")).to eq(true)
  end

  it "handles keys with duplicate characters: case 1" do
    expect(string_include_key?("adbblfci", "abbc")).to eq(true)
  end

  it "handles keys with duplicate characters: case 2" do
    expect(string_include_key?("adbclfci", "abbc")).to eq(false)
  end

  it "returns false if the key characters are in the wrong order" do
    expect(string_include_key?("dblfcia", "abc")).to eq(false)
  end

  it "returns false if the string doesn't contain the key" do
    expect(string_include_key?("db", "abc")).to eq(false)
  end

end
```
