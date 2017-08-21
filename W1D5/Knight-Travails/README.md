# Knight's Travails

**Read through all the instructions before beginning!**

## Learning Goals

* Be able to implement your PolyTreeNode to build a path from start to finish
* Know how to store and traverse a tree
* Know when and why to use BFS vs. DFS

## Phase 0: Description

In this project we will create a class that will find a path for a Chess Knight from a starting position to an end position. Both the start and end positions should be on a standard 8x8 chess board.

**NB**: this problem is a lot like word chains!

Write a class, `KnightPathFinder`. Initialize your `KnightPathFinder` with a starting position. For instance:

```ruby
kpf = KnightPathFinder.new([0, 0])
```

Ultimately, I want to be able to find paths to end positions:

```ruby
kpf.find_path([2, 1]) # => [[0, 0], [2, 1]]
kpf.find_path([3, 3]) # => [[0, 0], [2, 1], [3, 3]]
```

To help us find paths, we will build a **move tree**. The values in the tree will be positions. A node is a child of another node if you can move from the parent position directly to the child position. The root of the tree should be the knight's starting position. **You will want to build on your `PolyTreeNode` work, using `PolyTreeNode` instances to represent each position.**

You will be writing an instance method `KnightPathFinder#build_move_tree` to build the move tree and store it as an instance variable. Call this method in `initialize`; you will traverse the move tree whenever `#find_path` is called. **Don't write this yet though**.

## Phase I: `#new_move_positions`

Before we start `#build_move_tree`, you'll want to be able to find new positions you can move to from a given position. Write a **class** method `KnightPathFinder::valid_moves(pos)`. There are up to eight possible moves.

You'll also want to avoid repeating positions in the move tree. For instance, we don't want to infinitely explore moving betweeen the same two positions. Add an instance variable, `@visited_positions` to keep track of the positions you have visited; initialize it to the array containing just the starting pos. Write an **instance** method `#new_move_positions(pos)`; this should call the `::valid_moves` class method, but filter out any positions that are already in `@visited_positions`. It should then add the remaining new positions to `@visited_positions` and **return** these new positions.

## Phase II: `#build_move_tree`

Let's return to `#build_move_tree`. We'll use our `#new_move_positions` instance method.

To ensure that your tree represents only the shortest path to a given position, build your tree in a **breadth-first** manner. Take inspiration from your BFS algorithm: use a queue to process nodes in FIFO order. Start with a root node representing the `start_pos` and explore moves from one position at a time.

Next build nodes representing positions one move away, add these to the queue. Then take the next node from the queue... until the queue is empty.

When you have completed, and tested, `#build_move_tree` **get a code review from your TA**.

## Phase III: `#find_path`

Now that we have created our internal data structure (`@move_tree`), we can traverse it to find the shortest path to any position on the board from our original `@start_pos`.

Create an instance method `#find_path(end_pos)` to search for `end_pos` in the move tree. You can use either `dfs` or `bfs` search methods from the PolyTreeNode exercises; it doesn't matter. This should return the tree node instance containing `end_pos`.

This gives us a node, but not a path. Lastly, add a method `#trace_path_back` to `KnightPathFinder`. This should trace back from the node to the root using `PolyTreeNode#parent`. As it goes up-and-up toward the root, it should add each value to an array. `#trace_path_back` should **return** the values in order from the start position to the end position.

Use `#trace_path_back` to finish up `#find_path`.

Here are some example paths that you can use for testing purposes (yours might not be exactly the same, but should be the same number of steps);

```ruby
kpf = KnightPathFinder.new([0, 0])
kpf.find_path([7, 6]) # => [[0, 0], [1, 2], [2, 4], [3, 6], [5, 5], [7, 6]]
kpf.find_path([6, 2]) # => [[0, 0], [1, 2], [2, 0], [4, 1], [6, 2]]
```
