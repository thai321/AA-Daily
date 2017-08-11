# Test Driven Development

## Learning Goals

* Be able to explain what functionality your testing will cover
* Know the hierarchy / syntax of RSpec methods (`describe`, `before`, `let`,
`it`, `expect`, etc.)
* Be comfortable writing RSpec tests
* Know when to use `let` and `subject`

**Expected time: 2hrs**

Do all of the following exercises TDD.  That means writing specs **first**!  

When approaching each problem, make sure to:

  1. Read the entire problem statement.
  2. Talk with your partner to identify test cases and key functionality to expect from your code.
  3. Write RSpec tests.
  4. Write the method you now have tests for.  Follow the red-green-refactor approach until all specs pass.  

### Remove dups

Array has a `uniq` method that removes duplicates from an array. It
returns the unique elements in the order in which they first appeared:

```ruby
[1, 2, 1, 3, 3].uniq # => [1, 2, 3]
```

Write your own version of this method called `my_uniq`; it should take in an Array and return a new array.

### Two sum

Write a new `Array#two_sum` method that finds all pairs of
positions where the elements at those positions sum to zero.

NB: ordering matters. We want each of the pairs to be sorted
smaller index before bigger index. We want the array of pairs to be
sorted "dictionary-wise":

```ruby
[-1, 0, 2, -2, 1].two_sum # => [[0, 4], [2, 3]]
```

* `[0, 2]` before `[2, 1]` (smaller first elements come first)
* `[0, 1]` before `[0, 2]` (then smaller second elements come first)

### My Transpose

To represent a *matrix*, or two-dimensional grid of numbers, we can
write an array containing arrays which represent rows:

```ruby
rows = [
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8]
  ]

row1 = rows[0]
row2 = rows[1]
row3 = rows[2]
```

We could equivalently have stored the matrix as an array of
columns:

```ruby
cols = [
    [0, 3, 6],
    [1, 4, 7],
    [2, 5, 8]
  ]
```

Write a method, `my_transpose`, which will convert between the
row-oriented and column-oriented representations. You may assume
square matrices for simplicity's sake. Usage will look like the following:

```ruby
my_transpose([
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8]
  ])
 # => [[0, 3, 6],
 #    [1, 4, 7],
 #    [2, 5, 8]]
```

### Stock Picker

Write a method that takes an array of stock prices (prices on days 0,
1, ...), and outputs the most profitable pair of days on which to
first buy the stock and then sell the stock.  Remember, you can't sell stock before you buy it!

### Towers of Hanoi

Write a
[Towers of Hanoi](http://en.wikipedia.org/wiki/Towers_of_hanoi) game.

Keep three arrays, which represents the piles of discs. Pick a
representation of the discs to store in the arrays; maybe just a number
representing their size. Don't worry too much about making the user
interface pretty.

In a loop, prompt the user (using
[gets](http://andreacfm.com/ruby/2011/06/11/learning-ruby-gets-and-chomp.html))
and ask what pile to select a disc from, and where to put it.

After each move, check to see if they have succeeded in moving all the
discs, to the final pile. If so, they win!

**Note:** don't worry about testing the UI. Testing console I/O is tricky (don't bother checking `gets` or `puts`). Focus on:

  * `#move`
  * `#won?`

### Get a code review from a TA

## Resources

* [Ruby Doc on Array](http://www.ruby-doc.org/core-2.1.2/Array.html)
* [Ruby Monk Intro to Arrays](http://rubymonk.com/learning/books/1/chapters/1-arrays/lessons/2-arrays-introduction)
* [Ruby Array Article](http://zetcode.com/lang/rubytutorial/arrays/)
