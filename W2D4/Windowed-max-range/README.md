# Max Windowed Range

Given an array, and a window size `w`, find the maximum range
(`max - min`) within a set of `w` elements.

Let's say we are given the array [1, 2, 3, 5] and a window size of 3.
Here, there are only two cases to consider:

```
1. [1 2 3] 5
2. 1 [2 3 5]
```

In the first case, the difference between the max and min elements of
the window is two (`3 - 1 == 2`). In the second case, that difference is
three (`5 - 2 == 3`). We want to write a function that will return the
larger of these two differences.

## Learning Goals

* Get practice approaching a difficult problem using algorithms
* Be able to explain the time complexity of your solution
* Know the differences between a stack and a queue
* Be able to use simple data structures to build more complicated ones

## Naive Solution

One approach to solving this problem would be:

1. Initialize a local variable `current_max_range` to `nil`.
2. Iterate over the array and consider each window of size `w`. For each
   window:
  1. Find the `max` value in the window.
  2. Find the `min` value in the window.
  3. Calculate `max - min` and compare it to `current_max_range`. Reset
  the value of `current_max_range` if necessary.
3. Return `current_max_range`.

Implement this approach in a method, `max_windowed_range(array,
window_size)`. Make sure your code passes the following test cases:

```ruby
windowed_max_range([1, 0, 2, 5, 4, 8], 2) == 4 # 4, 8
windowed_max_range([1, 0, 2, 5, 4, 8], 3) == 5 # 0, 2, 5
windowed_max_range([1, 0, 2, 5, 4, 8], 4) == 6 # 2, 5, 4, 8
windowed_max_range([1, 3, 2, 5, 4, 8], 5) == 6 # 3, 2, 5, 4, 8
```

Think about the time complexity of your method. How many iterations are
required at each step? What is its overall time complexity in Big-O
notation?

## Optimized Solution

It turns out that it is quite costly to calculate the `min` and `max`
elements of each window. If we use the `min` and `max` methods built
into Ruby, this costs us `2 * window_size` iterations for each window.
What if it were possible to calculate `min` and `max` instantaneously
(in constant time)? We can write a data structure to help with this.

### Queues

In the naive solution, we consider each window as a slice of the input
array. On the first iteration, we slice the array from index `0` to
index `w`. On the second iteration, we slice from `1` to `w + 1`, and so
forth. However, slicing an array is rather costly. Since the window only
moves one index at a time, it would be nicer to represent it as a
**queue**. Every time we move the window, we could enqueue the next
element and dequeue the last element. However, that still leaves us with
the problem of expensive `max` and `min` operations. To solve this,
we'll write a hybrid data structure called a MinMaxStackQueue.

Let's take a detour to [write this data structure][stacks-and-queues].

[stacks-and-queues]: stacks-and-queues.md

**Do not move on until you have completed the Stacks and Queues
exercises!**

### Writing the Optimized Solution

Armed with a working MinMaxStackQueue, this problem should be much
easier. You'll want to follow the same basic approach as above, but use
your new data structure instead of array slices. As before, return the
`current_max_range` at the end of the method. Make sure all the test
cases pass, and that you both understand the time complexity of this
solution. Then talk to your TA about it and have them review your code!
