# Towers of Hanoi

## Learning Goals

+ Know how to use pseudocode to structure your reasoning
+ Be able to use JavaScript classes and objects in Node
  + Be able to use principle of object-oriented programming in JavaScript
+ Be comfortable testing methods as you write them
+ Be able to implement I/O using readline

Let's rewrite the towers of Hanoi game we [previously wrote in Ruby][ruby-hanoi].

Before you start, write out `Game.prototype.run` in pseudocode (using comments).
For example, if I were to write the pseudocode for `Chess.prototype.run`, it would
look something like:

```javascript
  class Chess {
    run() {
      // until a player is in checkmate
        // get move from current player
        // make move on board
        // switch current player
    }
  }
```

Save the pseudocode to a separate file.  We'll come back to it later.

Now write a `Game` class and run it using Node:

* In the `constructor`, set an ivar for the stacks.

* Write a `Game.prototype.promptMove` method that (1) prints the stacks,
  and (2) asks the user where they want to move a disc to/from. Pass
  the `startTowerIdx` and `endTowerIdx` to a callback.
    * Test it by passing in dummy variables and make sure it works
    before you move on.  For example, your callback should `console.log`
    out the `startTowerIdx` and `endTowerIdx` (and not run any other code).

* Write an `isValidMove(startTowerIdx, endTowerIdx)` method that
  checks that you can move the top of `startTowerIdx` onto the top of
  `endTowerIdx`.
  * Test it by passing in dummy variables and make sure it works before you move on.

See the theme here?  Test each method, one at a time, before you move on.

* Write a `move(startTowerIdx, endTowerIdx)` method that only performs
  the move if it is valid. Return true/false to indicate whether the
  move was performed.  Test it.

* Write a `print` method to print the stacks. I used `JSON.stringify`
  to turn the array of stacks to a string. This works sort of like
  Ruby's `#inspect` method (called by the Ruby `p` method). Test it.

* Write an `isWon` method that checks the stacks to see if all discs
  were moved to a new stack.  Test it by passing in dummy variables
  and make sure it works before you move on.

* Write a `Game.prototype.run(completionCallback)` method.
    * `promptMove` from the user.
    * In the callback, try to perform the move. If it fails, print an
      error message.
    * Test `run` here (yes, just make sure `promptMove` works within `run`).
    * If the game is not yet won, call `run` again.
    * Otherwise, log that the user has won, then call the
      `completionCallback`.
    * Test this out, should we call `isWon` in the top level of `run` or in the callback to `promptMove`?

Compare the `run` method you wrote to the pseudocode you originally had. Does it look like what you expected?

## Playing the Game

In order to play our game, we need to implement a layer of I/O to connect our
game logic to user input. Create a `playScript.js` file.
  * Import your game by requiring `./game.js` as `Game`.
  * Instantiate a reader using node's [readline library][node-io].
  * Write a completion callback to ask the users if they want to play again.
  * Instantiate a new `Game`, passing the reader and the completion callback.
  * Run the game; close the reader when done.

Instantiate the `Game` class and play a game. In the completion
callback, close your `reader` so that Node knows it can exit when the
game is over.

[ruby-hanoi]: ./ruby_hanoi.md
[node-io]: ../../readings/intro-to-callbacks.md
