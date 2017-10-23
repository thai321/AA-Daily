# Binary Search Trees


# Phase 1: Building a BST

In this project, we'll translate our conceptual idea of a binary search tree into a real, live Ruby object with all the functionality that we dreamt of.  

## The Setup

First, we must consider carefully how we'd like to represent our BST and the nodes within it. There is not a single "right" way to do this, but there are some time complexities and functionality that we *must* achieve, namely:

- **Nodes**: allows each node to hold a value, `val`, and accesses and sets that `val` in constant time,
- **Child/parent connections**: allows each node to hold a left child and/or a right child, with access to the children in constant time

Notice that we don't necessarily *need* to represent a node's `parent` connection explicitly; however, that might be a useful attribute to track should we ever need it.  

It'll be helpful to separate our concerns into two structures: `BSTNode` and `BinarySearchTree`.  Each `BSTNode` will hold the information relevant to an individual node: its value and pointers to its children. It's up to you whether or not you want to include the parent pointer, but do know that it could determine how your methods are later written in the `BinarySearchTree` class. The `BinarySearchTree` will house a collection of nodes tied together using the conceptual rules of the BST outlined in the videos and readings.  

## `BSTNode`

This class will be pretty simple. We need only an `#initialize` method and the appropriate `attr_accessor`s. Set these up in the BST class and make sure those specs pass.

## `BinarySearchTree`

Now comes the fun stuff. We'll recreate all the functionality discussed in the lecture on our `BinarySearchTree`, plus a couple extras.  

**NB: There are multiple ways to implement these various methods. If you need to, feel free to tweak the skeleton and add helper methods in order to write the methods in a way that makes sense to you, as long as it passes the specs. _However, please do not change the specs._** 

**In our implementation of the BST, some of these BST methods call on helper methods and allow for the recursion to happen in the helper methods. But again, it's up to you to decide how you want to implement your methods, as long as it properly executes what it needs to do on a Binary Search Tree.**

Also, in the skeleton file for the `BinarySearchTree` class, there are method arguments that have a variable named `tree_node`. A `tree_node` is essentially just a root node, and we call it a `tree_node` because it holds access to the rest of the tree. We didn't want to also call it `root_node` since we already had a `@root`. 

#### `#initialize`

Let's review how we conceptually created a binary search tree: we began with a root. Instantiate this within `#initialize`, and don't forget its accessor. Remember that the root is a node, but let's start it off equal to `nil`, and when we eventually insert the first element, then we'll set it to equal a node.

#### `#insert`

Recall our algorithm for inserting a node into a tree:

1. Compare the node's value to the root's value.
2. If the node is less than the root, insert into the left subtree. If there is no left subtree, the node becomes the root's left child.
3. If the node is greater than the root, insert into the right subtree. If there is no right subtree, the node becomes the root's right child.

Write this method.  `#insert` should take in a `value` and insert it into its proper position in the `BinarySearchTree`. Hint: this algorithm is recursive (in our solution, we use recursion in a helper method).

Once you have `#insert` working, go back and tweak it to account for duplicate values.

#### `#find`

Write a method that takes in a `value` and returns the node that has that value. If none of the nodes in the BST has that value, then return nil. Remember: a binary search tree keeps all nodes less than the root in its left subtree, and all nodes greater than the root in its right subtree.

**NB**: you had two choices for how to handle duplicates in `#insert`. Your implementation of `#find` will depend (to a small extent) on which of these choices you made.

#### `#delete`

This is the tricky one! Review the binary search tree reading for details. Here are the bullet points of the algorithm:

1. If a node has no children, simply remove it.
2. If a node has only one child, delete it and promote its child to take its place.
3. If a node has two children, find the largest node in its left subtree and promote that node to replace the deleted node. If necessary, promote that node's child to replace its parent.

You'll need a helper method, `#maximum`.  After that, the work that we want to do here essentially involves a lot of pointer swapping. Helper methods are recommended here!

#### `#is_balanced?` and `#depth`

Remember that a lynch pin in our binary search tree was ensuring that the tree was (and remained) *balanced* and thus maintained a depth that was approximately equal to `log (n)` where *n* is the number of nodes in the tree. Otherwise, we ended up with nasty cases like this one:

<img src="https://github.com/appacademy/sf-job-search-curriculum/blob/master/algorithms/binary_search_trees/diagrams/degnerate.png" />

We defined the *balanced* property as follows:

1. The depths of the left and right subtrees differ by at most 1,
2. Both the left and right subtrees are also balanced.

Write `#depth` first, as you will use this as a helper method in `#is_balanced?`. From there, recursion will once again be our friend.

#### `#in_order_traversal`

As our final Phase 1 exercise, let's implement `#in_order_traversal`, which returns the set of `value`s held by the nodes in the `BinarySearchTree` in sorted order. Recall our algorithm for this:

1. Perform an in-order traversal of the left subtree,
2. Print (or push) the value of the root,
3. Perform an in-order traversal of the right subtree.

Your `#in_order_traversal` method should return an array that contains the data set underlying the BST, in sorted order.

## What Our Tree Is and Isn't

Great job! You've built a basic BST. This structure has all the features of a binary search tree, but it's important to know what this tree isn't: it is *not* a self-balancing tree. That's important, because we have no safeguard to ensure that our time complexities remain logarithmic for `#find`, `#insert`, and `#delete`. After phase 2, as a bonus, you can try to create a self-balancing tree and implement the rebalacing algorithm.

Before you explore the world of AVL/self-balancing trees, go on to use your tree for some interview-style questions. It's more important that you do Phase 2 than the bonus, because phase 2 is similar to the kinds of exercises you may be expected to do on an actual interview. (No a/A student has ever been asked to implement a rebalancing algorithm or an AVL tree from scratch.  No one.)

Sally forth! Phase 2 awaits!  

## Phase 2: Binary Search Trees in Action

In this part of the lesson, let's do an interview problem that involves a BST.

#### `kth_largest`

In the file, `bst_practical.rb`, write a function that takes in a binary search tree (as a `tree_node`) and an integer *k*, and returns the <i>k</i>th largest element in the BST.