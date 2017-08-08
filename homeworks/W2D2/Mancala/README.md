# Mancala!

If you don't know how the game works, check out the rules below, or
check out this video: [How to Play Mancala](https://youtu.be/-A-djjimCcM)!
Even if you already know mancala, skim the rules. There are many different
ways to play mancala, and the specs are written to test one particular
version of the game. Read through all of the instructions before starting.

## Game Rules

- There are two players. Each has one side of the board, and they must
always *start* a turn on their side of the board.
- Game play always moves counter clockwise. Players pick up all of the
stones in the cup they start with. They then move cup-by-cup and put one
stone in each cup they pass, including their own points store. The only
exception is when they pass their opponent's points store; in that case,
they simply skip it.
  - e.g. Player 2 could start on cup 7 and move to cup 8, 9, 10, etc.,
  and, if they had enough stones, would put one in the `[player2 store]`
  when passing it. They could not start a turn on cups 1-6.
```
player 2:             12  11  10  9  8  7
              [player2 store]     [player1 store]
player 1:              1   2   3  4  5  6
```
- Depending on where the player ends, they will do different things. If
they place the last stone in:
  - their point store --> they get to play again, choosing a new starting
  cup on their side
  - a regular cup with stones in it --> they *must* pick up the stones in
  that cup and continue playing (even if it's on the opponent's side)
  - a regular cup that's empty --> their turn is over; switch players
- The game ends when one side is empty. At that point, the player with the
most stones in their points store wins.

## Getting Started

Download the [skeleton][mancala-skeleton].

Poke around. You will be writing the `Board` class, but first get acquainted
with the code provided in the `Player` and `Mancala` classes.

The gist:
* To play, create a new instance of `Mancala` and call `play` to kick things off.
* `Mancala#play` calls `#take_turn` alternating players until the game is `#won?`
* `Mancala#take_turn` encapsulates the trickier logic of the game. It relies on
the **return value** of `Board#make_move` to determine whether the turn is over or not.
  - If the player ends in their own cup, the return value should be
  `:prompt`, the turn is *not* over yet, and `Mancala#take_turn` should
  prompt the current player for the next starting cup
  - If the current player ends on a cup that already has stones in it,
  the return value should be the `ending_cup_idx` and the game automatically
  plays the next turn, since the rules dictate that a player must then
  pick up the stones in that cup.
  - If the current player ends on an empty cup (that now has one stone
    in it), the return value should be `:switch`. `Mancala#take_turn`
    will then switch players and repeat the process until someone has won.
  + Our `Board` class houses this logic because the next turn is determined
  by the board's state after interacting with the player.

**NB:**
 + Run `bundle install` to make sure you're using the correct version of RSpec!
 + Run the specs using the `--order default` option, like so:
 `bundle exec rspec --order default`.
 + Do not try calling `Mancala#play` until you have written the `Board` class!
 It won't work.

[mancala-skeleton]: skeleton.zip?raw=true

## Writing the `Board` class

Run the specs. Skim the failed spec messages, along with the outline of the
`Board` class provided. These two things together should give you a sense of how
a board is expected to interact with the other classes.

The specs are your instructions; let them guide you!

A few :key: things to note:
 * `player1`, `name1`, and `side1` all correspond to the same player.
 * A *cup* is an Array of stones. The number of stones in a cup corresponds
 to its length. An empty cup has the length of 0.
 * Call `Board#render` to the board at the end of each move.
 * `Player#prompt` requires the input to be either `1..6` or `7..12`,
 but `Board#make_move` should *transpose* the bottom half to `0..5`.
 This is based on the assumption that it's more user-friendly to only
 number the cups they can start with (i.e. not the points stores) and to
 start numbers at 1. But within our `Board` class, the points stores are,
 of course, elements in the array, so we need to account for them.
   * The player sees and uses:
   ```
       12  11  10  9  8  7
   [store2]            [store1]
        1   2   3  4  5  6
   ```
   * Our board is actually setup like this:
   ```
       12  11  10  9  8  7
   [13]                   [6]
        0   1   2  3  4  5
   ```
   * Make sure to account for this difference!

When you have all of your specs passing you are finished! Double check
your [solutions][mancala-solutions] and go play Mancala!

[mancala-solutions]: solution
