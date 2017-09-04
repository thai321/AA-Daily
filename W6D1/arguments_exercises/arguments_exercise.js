// Write a sum function that takes any number of arguments:
//  sum(1, 2, 3, 4) === 10
// sum(1, 2, 3, 4, 5) === 15
// Solve it first using the arguments keyword,
// then rewrite your solution to use the ... rest operator.
console.log('----- Sum -----');

function sum1() {
  let args = Array.from(arguments);
  let total = 0;

  for (let i = 0; i < args.length; i++) {
    total += args[i];
  }

  return total;
}
function sum2(...args) {
  return args.reduce((a, b) => a + b);
}

console.log(sum1(1, 2, 3, 4) === 10);
console.log(sum1(1, 2, 3, 4, 5) === 15);
console.log(sum2(1, 2, 3, 4) === 10);
console.log(sum2(1, 2, 3, 4, 5) === 15);

/*

=============================
bind with args

Rewrite your myBind method so that it can take both bind-time arguments
and call-time arguments.

Solve it first using the arguments keyword.

Within your myBind method, you'll have to define a new,
anonymous function to be returned. Be careful: using arguments inside
the anonymous function will not give you the arguments passed to myBind,
because arguments is reset on every function invocation (just like this).

That makes sense, because there are two arrays of arguments
you care about: the extra arguments passed to myBind,
and the arguments passed when the bound function is called.

Once you've done that, write a second version using the ... rest operator.
*/
console.log('\n--------bind with args------');

Function.prototype.myBind = function myBind(contex) {
  const args = Array.from(arguments).slice(1);
  const that = this;

  return function() {
    const newArgs = Array.from(arguments);
    const allArgs = args.concat(newArgs);
    return that.apply(contex, allArgs);
  };
};

Function.prototype.myBind2 = function myBind2(contex, ...args) {
  return (...newArgs) => {
    return this.apply(contex, args.concat(newArgs));
  };
};

class Cat {
  constructor(name) {
    this.name = name;
  }

  says(sound, person) {
    console.log(`${this.name} says ${sound} to ${person}!`);
    return true;
  }
}

const markov = new Cat('Markov');
const breakfast = new Cat('Breakfast');

markov.says('meow', 'Ned');
// Markov says meow to Ned!
// true

// bind time args are "meow" and "Kush", no call time args
markov.says.myBind(breakfast, 'meow', 'Kush')();
markov.says.myBind2(breakfast, 'meow', 'Kush')();
// Breakfast says meow to Kush!
// true

// no bind time args (other than context), call time args are "meow" and "me"
markov.says.myBind(breakfast)('meow', 'a tree');
markov.says.myBind2(breakfast)('meow', 'a tree');
// Breakfast says meow to a tree!
// true

// bind time arg is "meow", call time arg is "Markov"
markov.says.myBind(breakfast, 'meow')('Markov');
markov.says.myBind2(breakfast, 'meow')('Markov');
// Breakfast says meow to Markov!
// true

// no bind time args (other than context), call time args are "meow" and "me"
const notMarkovSays = markov.says.myBind(breakfast);
notMarkovSays('meow', 'me');

const notMarkovSays2 = markov.says.myBind2(breakfast);
notMarkovSays2('meow', 'me');
// Breakfast says meow to me!
// true

/*
#######################
curriedSum

Functional programming is another programming paradigm.
It's an alternative to object-oriented programming,
though the two can also be mixed. We'll learn more about it later,
but briefly, functional programming focuses on function composition
(writing functions which are given a function as an argument and return a new function).

One pattern seen in functional programming is currying.
Currying is the process of decomposing a function that takes
multiple arguments into one that takes single arguments successively
until it has the sufficient number of arguments to run.
This technique is named after the logician Haskell Curry
(the functional programming language Haskell is, too).

Here's an example of two ways to use a sumThree function.
The first is a typical version that takes 3 arguments;
the second is a curried version:

function sumThree(num1, num2, num3) {
  return num1 + num2 + num3;
}

sumThree(4, 20, 6); // == 30

// you'll write `Function#curry`!
let f1 = sumThree.curry(3);
// tells `f1` to wait until 3 arguments are given before running `sumThree`

f1 = f1(4); // [Function]
f1 = f1(20); // [Function]
f1 = f1(6); // = 30

// or more briefly:
sumThree.curry(3)(4)(20)(6); // == 30


Note that the curried version returns functions at
each invocation until it has the full number of arguments it needs.
At this point it actually invokes sumThree and returns the result.

Write a curriedSum function that takes an integer
(how many numbers to sum) and returns a function that
can be successively called with single arguments until it finally returns a sum.
That is:

const sum = curriedSum(4);
sum(5)(30)(20)(1); // => 56


Hint: curriedSum(numArgs) should:

_ Define an empty array, numbers.
_ Defines a function, _curriedSum that:
  + Closes over numArgs and numbers.
  + Takes a single number as an argument.
  + Appends this to numbers each time.
  + If numbers.length === numArgs, it sums the numbers in the array and returns the result.
  + Else, it returns itself.
_ Returns _curriedSum.

If you're confused, think of it this way:
_curriedSum keeps collecting arguments and
returning itself until it has enough arguments,
at which point it actually does the required work of summing.
*/

console.log('\n-------------- curriedSum ---------');

function curriedSum(numArgs) {
  const numbers = [];

  function _curriedSum(n) {
    numbers.push(n);

    if (numbers.length === numArgs) return numbers.reduce((a, b) => a + b);
    else return _curriedSum;
  }

  return _curriedSum;
}

function sumThree(num1, num2, num3) {
  return num1 + num2 + num3;
}

console.log(sumThree(4, 20, 6) === 30); // == 30

const sum = curriedSum(4);
console.log(sum(5)(30)(20)(1) === 56); // => 56

/*
=========================
Function.prototype.curry

Write a method Function.prototype.curry(numArgs).
This should return a function that will:

_ Collect up arguments until there are numArgs of them,
_ If there are too few arguments still, it should return itself.
_ When there are numArgs arguments, it should call the original function.
_ Write a version that uses Function.prototype.apply and another
_ one that uses ... the spread operator.

** Make sure to call a TA to check over your work if you haven't already! **

*/

Function.prototype.curry1 = function curry1(numArgs) {
  const args = [];
  const that = this;

  function _curry(item) {
    args.push(item);

    if (args.length === numArgs) return that.apply(null, args);
    else return _curry;
  }

  return _curry;
};

Function.prototype.curry2 = function curry2(numArgs) {
  const args = [];
  const that = this;

  function _curry(item) {
    args.push(item);

    if (args.length === numArgs) return that(...args);
    else return _curry;
  }

  return _curry;
};

console.log(sumThree.curry1(3)(30)(20)(1) === 51);
console.log(sumThree.curry2(3)(30)(20)(1) === 51);
