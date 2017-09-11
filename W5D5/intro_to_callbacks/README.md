# Intro to Callbacks Exercises

## Learning Goals

+ Know how to use `setInterval` to schedule recurring function calls
+ Know how to pass functions into `setInterval`
+ Be able to set the context of a function
+ Know how to use callbacks to enforce the order of asynchronous function calls
+ Know how to write `myBind`

Note: Write user interaction with node's `readline` library.

Useful Readings:
+ [Closures and Scope][closures]
+ [`this` and that][this-and-that]
+ [Intro. to Callbacks: File I/O][intro-to-callbacks]

[closures]: ../../readings/closures.md
[this-and-that]: ../../readings/this-and-that.md
[intro-to-callbacks]: ../../readings/intro-to-callbacks.md

## Timing is Everything

Use [`setInterval`][setInterval-doc] to build a small clock in your
terminal. It should display the current time every second. However, you
can only query the system time once. Your clock must store that time,
increment it, and display it in `HH:MM:SS` (use 24hr format).

Make a `Clock` class. Calling `new Date()` will give us an object that
represents the current system time. Because you can only do this once,
do it in your `Clock` `constructor`. Don't bother keeping this `Date` object
around because you won't need it anymore. Just store the hours, minutes,
and seconds. Look at the [`Date` docs][date-docs] for help here.

You'll also need to schedule a `Clock.prototype._tick` callback that
updates the time and calls `printTime` method. Don't worry about padding
zeroes in the format. Just focus on the basic logic and functionality.

```javascript
class Clock {
  constructor() {
    // 1. Create a Date object.
    // 2. Store the hours, minutes, and seconds.
    // 3. Call printTime.
    // 4. Schedule the tick at 1 second intervals.
  }

  printTime() {
    // Format the time in HH:MM:SS
    // Use console.log to print it.
  }

  _tick() {
    // 1. Increment the time by one second.
    // 2. Call printTime.
  }
}

const clock = new Clock();
```

[setInterval-doc]: http://nodejs.org/api/globals.html#globals_setinterval_cb_ms
[date-docs]: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Date#Date.prototype_Methods

### `addNumbers`

Let's write a function that will read several numbers, one after
another, and sum up the total. After each number, let's print out the
partial sums along the way, and pass the total sum to a callback when
done.

First off, use `readline.createInterface` to create a global variable,
`reader`. Use `process.stdin`/`process.stdout` like I do in my
examples. **Make sure to only use one instance of a reader and only close it once**.

Next, write a function, `addNumbers(sum, numsLeft,
completionCallback)`:

* If `numsLeft > 0`, then:
    * Prompt the user for a number (use `reader`).
    * Pass a callback that:
    * Uses `parseInt` to parse the input.
    * Increment the `sum` and `console.log` it.
    * Recursively calls `addNumbers` again, passing in:
        * the increased `sum`,
        * the decreased `numsLeft`,
        * and the same `completionCallback`.
* If `numsLeft === 0`, call `completionCallback(sum)` so that the total
  sum can be used.

To test, try out:

```javascript
addNumbers(0, 3, sum => console.log(`Total Sum: ${sum}`));
```

This should prompt for three numbers, printing out the partial sums
and then the final, total sum.

### `absurdBubbleSort`

In this exercise, we write a method called `absurdBubbleSort(arr,
sortCompletionCallback)`. Instead of using the traditional `>`, we'll
prompt the user to perform each comparison for us.

First, write a method `askIfGreaterThan(el1, el2, callback)` which
prompts the user to compare two elements. The user can type in `"yes"`
or `"no"`: if the user indicates that `el1 > el2`, `askIfGreaterThan`
should call `callback` with `true`. Else, it should call `callback`
with `false`.

You'll want to set up a global `reader` variable (use
`readline.createInterface`). `askIfGreaterThan` should use the `question`
method.

Test it out.  Make sure you can ask for input and that the input passes
to the callback correctly.

Next, write a method `innerBubbleSortLoop(arr, i, madeAnySwaps,
outerBubbleSortLoop)`. This recursive function should:

* If `i < arr.length - 1`, it should call `askIfGreaterThan`, asking the
  user to compare `arr[i]` and `arr[i + 1]`.
* For a `callback` to `askIfGreaterThan`, pass in an anonymous helper
  function. This should:
    * Take in a single argument: `isGreaterThan`; `askIfGreaterThan`
      will pass either `true` or `false` as this argument.
    * Perform a swap of elements in the array if necessary.
    * Call `innerBubbleSortLoop` again, this time for `i + 1`. It should
      pass `madeAnySwaps`. Update `madeAnySwaps` if you did swap.
* Call `outerBubbleSortLoop` if `i == (arr.length - 1)`. It should
  receive `madeAnySwaps` as an argument.

This method should now perform a single pass of bubble sort.  Test out
`innerBubbleSortLoop`, passing in dummy variables.  For example, instead
of actually writing the `outerBubbleSortLoop` method, pass in a dummy
method that console.logs "In outer bubble sort".

This idea (testing methods on their own by passing in dummy arguments)
is *crucial* to understand larger chunks of code that you write.  Don't
be embarrassed to test out methods after you've only written one line of
them.  It's very bad software practice to write many lines of code before
testing anything, especially if you're a junior developer.

Lastly, write a method `absurdBubbleSort(arr, sortCompletionCallback)`.
Define a function `outerBubbleSortLoop` inside of `absurdBubbleSort`.
It should:

* If `madeAnySwaps == true`, call `innerBubbleSortLoop`. It should
  pass in `arr`, an index of `0`, and `false` to indicate that no
  swaps have been made. For a callback to `innerBubbleSortLoop`, pass
  `outerBubbleSortLoop` itself.
* If `madeAnySwaps == false`, sorting is done! call
  `sortCompletionCallback`, passing in `arr`, which is now sorted!

To kick things off, `absurdBubbleSort` should call
`outerBubbleSortLoop(true)`. This will call the first inner loop to be
run.

Here's a code skeleton:

```javascript
const readline = require("readline");

const reader = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});

// Write this first.
function askIfGreaterThan(el1, el2, callback) {
  // Prompt user to tell us whether el1 > el2; pass true back to the
  // callback if true; else false.
}

// Once you're done testing askIfGreaterThan with dummy arguments, write this.
function innerBubbleSortLoop(arr, i, madeAnySwaps, outerBubbleSortLoop) {
  // Do an "async loop":
  // 1. If (i == arr.length - 1), call outerBubbleSortLoop, letting it
  //    know whether any swap was made.
  // 2. Else, use `askIfGreaterThan` to compare `arr[i]` and `arr[i +
  //    1]`. Swap if necessary. Call `innerBubbleSortLoop` again to
  //    continue the inner loop. You'll want to increment i for the
  //    next call, and possibly switch madeAnySwaps if you did swap.
}

// Once you're done testing innerBubbleSortLoop, write outerBubbleSortLoop.
// Once you're done testing outerBubbleSortLoop, write absurdBubbleSort.

function absurdBubbleSort(arr, sortCompletionCallback) {
  function outerBubbleSortLoop(madeAnySwaps) {
    // Begin an inner loop if you made any swaps. Otherwise, call
    // `sortCompletionCallback`.
  }

  // Kick the first outer loop off, starting `madeAnySwaps` as true.
}

absurdBubbleSort([3, 2, 1], function (arr) {
  console.log("Sorted array: " + JSON.stringify(arr));
  reader.close();
});
```

## Function Calling

Write your own `myBind(context)` method. Add it to
`Function.prototype`. You'll want to:

1. Return an arrow function.
2. The arrow function captures `this` and `context`.
3. In the anonymous function, call `Function.prototype.apply` on `this`, passing
   the `context`.

Assume the method you're binding doesn't take any arguments; we'll see
tomorrow how to use the rest and spread operators to fix this.

How would you test your "bind" method out?  Try out this example code:

```js
class Lamp {
  constructor() {
    this.name = "a lamp";
  }
}

const turnOn = function() {
   console.log("Turning on " + this.name);
}

const lamp = new Lamp();

turnOn(); // should not work the way we want it to

const boundTurnOn = turnOn.bind(lamp);
const myBoundTurnOn = turnOn.myBind(lamp);

boundTurnOn(); // should say "Turning on a lamp"
myBoundTurnOn(); // should say "Turning on a lamp"


```

## Bonus Round

After you finish the remaining projects for the day
(Tic Tac Toe and Hanoi), go back and refactor the asynchronous
exercises to use [ES6 Promises][promise].

[promise]: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Promise
