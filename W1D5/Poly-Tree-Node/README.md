# Intro Algorithms and Data Structures

If you need a refresher on algorithms and data structures, refer to the
[reading][intro-algos] from last night!

Estimated time: 2hrs

[intro-algos]: ../../readings/intro-algorithms-and-data-structures.md

## Learning Goals

* Know how to implement a polytree using polytree nodes
* Know how to implement BFS and DFS for your polytree
* Be able to explain the differences between BFS and DFS and when one might be
preferred

## Phase 0: Description

Download [this skeleton][tree-node-rspec].

Write a class named `PolyTreeNode` which represents a node in a
tree. We'll write a tree node class that can have an arbitrary number
of children (not just two left/right children). It should have the
following interface:

## Phase 1: Implement a TreeNode class

* Write a class with four methods:
    * An `#initialize(value)` method that sets the value, and starts
      `parent` as nil, and `children` to an empty array.
    * A `#parent` method that returns the node's parent.
    * A `#children` method that returns an array of children of a
      node.
    * A `#value` method that returns the value stored at the node.
* Write a `#parent=` method which (1) sets the parent property and (2)
  adds the node to their parent's array of children (unless we're
  setting parent to `nil`).

Run `bundle exec rspec` to run the provided tests. At this point, all
the specs for `#initialize` and most of the specs for `#parent=` should pass.
(We'll get to the other specs soon!)

## Phase 2: Re-assigning Parents

Your `#parent=` code likely leaves a mess when re-assigning a
parent. Here's what I mean:

```ruby
n1 = PolyTreeNode.new("root1")
n2 = PolyTreeNode.new("root2")
n3 = PolyTreeNode.new("root3")

# connect n3 to n1
n3.parent = n1
# connect n3 to n2
n3.parent = n2

# this should work
raise "Bad parent=!" unless n3.parent == n2
raise "Bad parent=!" unless n2.children == [n3]

# this probably doesn't
raise "Bad parent=!" unless n1.children == []
```

In addition to (1) re-assigning the parent attribute of the child and
(2) adding it to the new parent's array of children, we should also
**remove** the child from the **old** parent's list of children (if
the old parent isn't `nil`). Modify your `#parent=` method to do this.

**Make sure all the `#parent=` specs pass before proceeding!**

## Phase 3: Adding Children

The easiest phase!

Write `add_child(child_node)` and `remove_child(child_node)` methods. These methods should be one- or two-liners that call `#parent=`.

## Phase 4: Searching

* Write a `#dfs(target_value)` method which takes a value to search for and
  performs the search. Write this recursively.
    * First, check the value at this node. If a node's value matches
      the target value, return the node.
    * If not, iterate through the `#children` and repeat.
* Write a `#bfs(target_value)` method to implement breadth first search.
    * You will use a local `Array` variable as a queue to implement
      this.
    * First, insert the current node (`self`) into the queue.
    * Then, in a loop that runs until the array is empty:
        * Remove the first node from the queue,
        * Check its value,
        * Push the node's children to the end of the array.
* Prove to yourself that this will check the nodes in the right
  order. Draw it out. **Show this explanation to your TA.**
* Get your TA to check your work!
* Make sure **all** the specs pass.

## References

* [Overriding inspect][overriding-inspect]
* Wikipedia: [Data structure][wiki-data-structure]
* Wikipedia: [Algorithm][wiki-algorithm]

[wiki-data-structure]: http://en.wikipedia.org/wiki/Data_structure
[wiki-algorithm]: http://en.wikipedia.org/wiki/Algorithm
[tree-node-rspec]: ./skeleton.zip?raw=true
[overriding-inspect]: ../../readings/overriding_inspect.md
