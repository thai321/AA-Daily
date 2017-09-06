# JS Intro Problems

Code up the following functions and run them in Node.

## Phase I - JS Fundamentals

### Mystery Scoping with `var`, `let`, `const`

Test out each of following functions in Node. What does each log to the console? Do any of them throw errors? See if you can figure out why.

```javascript
function mysteryScoping1() {
  var x = 'out of block';
  if (true) {
    var x = 'in block';
    console.log(x);
  }
  console.log(x);
}

function mysteryScoping2() {
  const x = 'out of block';
  if (true) {
    const x = 'in block';
    console.log(x);
  }
  console.log(x);
}

function mysteryScoping3() {
  const x = 'out of block';
  if (true) {
    var x = 'in block';
    console.log(x);
  }
  console.log(x);
}

function mysteryScoping4() {
  let x = 'out of block';
  if (true) {
    let x = 'in block';
    console.log(x);
  }
  console.log(x);
}

function mysteryScoping5() {
  let x = 'out of block';
  if (true) {
    let x = 'in block';
    console.log(x);
  }
  let x = 'out of block again';
  console.log(x);
}
```

### `madLib`

Write a function that takes three strings - a verb, an adjective, and a noun - uppercases and interpolates them into the sentence "We shall **VERB** the **ADJECTIVE** **NOUN**". Use ES6 template literals.

For example,
```js
> madLib('make', 'best', 'guac');
"We shall MAKE the BEST GUAC."
```

### `isSubstring`
**Input**
* 1) A String, called `searchString`.
* 2) A String, called `subString`.

**Output:** A Boolean. `true` if the `subString` is a part of the `searchString`.

```js
> isSubstring("time to program", "time")
true

> isSubstring("Jump for joy", "joys")
false
```

## Phase II - JS Looping Constructs

Carry on! Know your loops!

### `fizzBuzz`
3 and 5 are magic numbers.

Define a function `fizzBuzz(array)` that takes an array and returns a new array of
every number in the array that is divisible by either 3 or 5, but not both.

### `isPrime`

Define a function `isPrime(number)` that returns `true` if `number` is prime.
Otherwise, `false`. Assume `number` is a positive integer.

```javascript
> isPrime(2)
true

> isPrime(10)
false

> isPrime(15485863)
true

> isPrime(3548563)
false
```

### `sumOfNPrimes`

Using `firstNPrimes`, write a function `sumOfNPrimes(n)` that returns the sum of
the first `n` prime numbers. Hint: use `isPrime` as a helper method.

```javascript
> sumOfNPrimes(0)
0

> sumOfNPrimes(1)
2

> sumOfNPrimes(4)
17
```



-----------------


# Additional JS Intro Problems

Code up the following functions and run them in Node.

## Phase I: Callbacks

Write a function `titleize` that takes an array of names and a function
(callback). `titleize` should use `Array.prototype.map` to create a new array
full of titleized versions of each name - titleize meaning "Roger" should be
made to read "Mx. Roger Jingleheimer Schmidt". Then pass this new array of names
to the callback, which should use `Array.prototype.forEach` to print out each
titleized name.

```js
> titleize(["Mary", "Brian", "Leo"], printCallback);
Mx. Mary Jingleheimer Schmidt
Mx. Brian Jingleheimer Schmidt
Mx. Leo Jingleheimer Schmidt
undefined
```

Make sure it works before moving on!

## Phase II: Constructors, Prototypes, and `this`

First write a constructor function for an elephant. Each elephant should have a
name, height (in inches), and array of tricks in gerund form (e.g. "painting a
picture" rather than "paint a picture").

Next write a few prototype functions that will be shared among all elephants:
- `Elephant.prototype.trumpet`: should print "(name) the elephant goes 'phrRRRRRRRRRRR!!!!!!!'"
- `Elephant.prototype.grow`: should increase the elephant's height by 12 inches
- `Elephant.prototype.addTrick(trick)`: add a new trick to their existing repertoire
- `Elephant.prototype.play`: print out a random trick, e.g. "(name) is (trick)!"
  - Hint: look up some JS `Math` methods!

Make sure to create an elephant and test all of these functions out on them method style!

## Phase III: Function Invocation

First, let's make a few elephants so we have a small herd. Feel free to copy the code below, or to make your own with any attributes you like. Make sure to store all of our elephants in an array.

```js
let ellie = new Elephant("Ellie", 185, ["giving human friends a ride", "playing hide and seek"]);
let charlie = new Elephant("Charlie", 200, ["painting pictures", "spraying water for a slip and slide"]);
let kate = new Elephant("Kate", 234, ["writing letters", "stealing peanuts"]);
let micah = new Elephant("Micah", 143, ["trotting", "playing tic tac toe", "doing elephant ballet"]);

let herd = [ellie, charlie, kate, micah];
```

Now let's create a function called `paradeHelper` that we'll use to have an elephant parade. It should take a single elephant as an argument; this way, we can pass it as a callback to `forEach` when called on our herd. Make sure to store it as a property on the `Elephant` object. You can populate it with any `console.log` statement you want to build your parade (e.g. "_______ is trotting by!").

For example:

```js
> Elephant.paradeHelper(micah);
Micah is trotting by!
undefined
```

Once you have this function, call `forEach` on the herd and pass it in as the callback without invoking it. Elephants galore!

:elephant: :elephant: :elephant: :elephant:

## Phase IV: Closures

Let's make a function `dinerBreakfast`. Ultimately, we want it to return an anonymous closure, which we will be able to use to keep adding breakfast foods to our initial order.

```js
> let bfastOrder = dinerBreakfast();
"I'd like cheesy scrambled eggs please"
> bfastOrder("chocolate chip pancakes");
"I'd like cheesy scrambled eggs and chocolate chip pancakes please."
> bfastOrder("grits");
"I'd like cheesy scrambled eggs and chocolate chip pancakes and grits please."
```

Hints:
- `order` should be initialized to a starting order (e.g. scrambled eggs and bacon) before the anonymous function can do its work.
- The closure should capture/close over `order`
- What should the return value of `dinerBreakfast` be?
- Which function should take in the additional food as an argument?

Make sure you can call it multiple times and keep chaining on more breakfast foods!
