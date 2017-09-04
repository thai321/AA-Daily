### Base Converter

```js
// Write a recursive method that takes in a base 10 number n and
// converts it to a base b number. Return the new number as a string
//
// E.g. base_converter(5, 2) == "101"
// base_converter(31, 16) == "1f"

function baseConverter(n, b) {
  if (n < b) return n;
  if (n === 0) return '';
  const digits = '0123456789abcdef'.split('');

  return baseConverter(Math.floor(n / b), b) + digits[n % b];
}

console.log(baseConverter(5, 2)); // 101
console.log(baseConverter(31, 16)); // 1f
```
----------------

### Binary Search

```js
function myBsearch(array, target) {
  if (array.length === 0) return -1;

  const mid = Math.floor(array.length / 2);

  if (array[mid] === target) {
    return mid;
  } else if (array[mid] > target) {
    return myBsearch(array.slice(0, mid), target);
  } else {
    const result = myBsearch(array.slice(mid + 1), target);
    return result === -1 ? -1 : mid + 1 + result;
  }
}

console.log(myBsearch([1, 2, 3, 4, 5], 2)); // 1
console.log(myBsearch([1, 2, 3, 4, 5], 5)); // 4
console.log(myBsearch([1, 2, 3, 4, 5], 6)); // -1

```
------------

### Bubble Sort

```js
Array.prototype.bubbleSort = function() {
  for (let i = this.length; i > 0; i--) {
    for (let j = 0; j < i; j++) {
      if (this[j] > this[j + 1]) {
        const temp = this[j];
        this[j] = this[j + 1];
        this[j + 1] = temp;
      }
    }
  }
  return this;
};

console.log([1, 6, 3, 8, 6, 5, 10].bubbleSort()); // [1,3,5,6,6,8.10]
```
----------------

### Caesar Cipher
```js
function caesarCipher(str, shift) {
  const alpha = 'abcdefghijklmnopqrstuvwxyz'.split('');
  const result = [];

  for (let i = 0; i < str.length; i++) {
    if (str[i] === ' ') {
      result.push(' ');
      continue;
    }

    let currentIdex = alpha.indexOf(str[i]);
    let newIndex = (currentIdex + shift) % alpha.length;
    result.push(alpha[newIndex]);
  }
  return result.join('');
}

console.log(caesarCipher('aaa', 1)); // bbb
console.log(caesarCipher('abc xyz', 3)); // def abc
console.log(caesarCipher('the bear', 3)); // wkh ehdu
```
--------

### curriedSum

```js
// Write a curriedSum function that takes an integer (how many numbers
// to sum) and returns a function that can be successively called with
// single arguments until it finally returns a sum. That is:

function curriedSum(numArgs) {
  const numbers = [];

  function curry(num) {
    numbers.push(num);

    if (numbers.length === numArgs) {
      let total = 0;
      numbers.forEach(n => {
        total += n;
      });

      return total;
    } else {
      return curry;
    }
  }

  return curry;
}

const sum = curriedSum(4);
console.log(sum(5)(30)(20)(1)); // => 56
```

-------

### Function.prototype.curry

```js
// Write a method Function.prototype.curry(numArgs). This should return a function that will:
//
// Collect up arguments until there are numArgs of them,
// If there are too few arguments still, it should return itself.
// When there are numArgs arguments, it should call the original function.
// Write a version that uses Function.prototype.apply and another one that uses ... the spread operator.

// using spread
Function.prototype.curry = function(numArgs) {
  const args = [];
  const func = this;

  function curry(num) {
    args.push(num);

    if (args.length === numArgs) {
      return func(...args);
    } else {
      return curry;
    }
  }

  return curry;
};

// using apply
Function.prototype.curry1 = function(numArgs) {
  const args = [];
  let fn = this;

  function _curried(num) {
    args.push(num);
    if (args.length == numArgs) {
      return fn.apply(null, args);
    } else {
      return _curried;
    }
  }

  return _curried;
};

function sumThree(num1, num2, num3) {
  return num1 + num2 + num3;
}
let cur = sumThree.curry(3)(4)(20)(6);
console.log(cur); // 30

function sumThree2(num1, num2, num3) {
  return num1 + num2 + num3;
}
let cur1 = sumThree2.curry1(3)(4)(20)(6);
console.log(cur1); // 30

```
--------

### Digital Root


```js
// Write a method, `digital_root(num)`. It should Sum the digits of a positive
// integer. If it is greater than 10, sum the digits of the resulting number.
// Keep repeating until there is only one digit in the result, called the
// "digital root". **Do not use string conversion within your method.**
//
// You may wish to use a helper function, `digital_root_step(num)` which performs
// one step of the process.

const digitalRoot = num => {
  if (num < 10) return num;

  num = digitalRootStep(num);
  return num < 10 ? num : digitalRoot(num);
};

const digitalRootStep = num => {
  sum = 0;

  while (num > 0) {
    sum += num % 10;
    num = Math.floor(num / 10);
  }

  return sum;
};

console.log(digitalRoot(27)); // 9
console.log(digitalRoot(99)); // 9
console.log(digitalRoot(62)); // 8
```
-----------

### Doubler

```js
// Doubler

const doubler = array => {
  let result = array.map(e => e * 2);
  return result;
};

console.log(doubler([1, 2, 3])); // [2,4,6]
```
-------

### Dups/removeDups/ uniq

```js
// I feel like this should actually be called 'removeDups' or 'uniq'
// but I don't make the rules I just play by them.

Array.prototype.dups = function() {
  const result = [];
  const memo = {};

  this.forEach(e => {
    if (!memo[e]) {
      result.push(e);
      memo[e] = true;
    }
  });

  return result;
};

console.log([1, 1, 1, 2, 2, 3, 4, 4, 3, 4, 5, 5, 5].dups()); // [1,2,3,4,5]

```


--------

### Exponent

```js
// return b^n recursively. Your solution should accept negative values
// for n

const exponent = (b, n) => {
  if (n === 0) return 1;

  if (n > 0) {
    return b * exponent(b, n - 1);
  } else {
    return (1 / b) * exponent(b, n + 1);
  }
};

console.log(exponent(3, 3)); // 27

```
------

### Factorial Recursive



```js
// Write a recursive method that returns the first "num" factorial numbers.
// Note that the 1st factorial number is 0!, which equals 1. The 2nd factorial
// is 1!, the 3rd factorial is 2!, etc.

const factorialsRec = num => {
  if (num === 1) return [1];
  if (num === 2) return [1, 1];

  const result = factorialsRec(num - 1);
  const newItem = result.slice(-1) * (num - 1);
  result.push(newItem);
  return result;
};

console.log(factorialsRec(5)); // [1,1,2,6,24]
```


--------

### Factors

```js

// Write a method that returns the factors of a number in ascending order.

const factors = num => {
  if (num === 1) return 1;

  const result = [1];

  for (let i = 2; i < num; i++) {
    if (num % i === 0) result.push(i);
  }

  result.push(num);
  return result;
};

console.log(factors(10)); // [1, 2, 5, 10]
console.log(factors(13)); // [1, 13]
```


--------

### Fibonacci Sum Recursive

```js
// Implement a method that finds the sum of the first n
// fibonacci numbers recursively. Assume n > 0

const fibSum = num => {
  if (num === 1) return 1;
  if (num === 2) return 2;

  const current = singleFib(num);
  return current + fibSum(num - 1);
};

const singleFib = n => {
  if (n === 1) return 1;
  if (n === 2) return 1;

  return singleFib(n - 1) + singleFib(n - 2);
};
console.log(fibSum(1)); // 1
console.log(fibSum(2)); // 2
console.log(fibSum(5)); // [1,1,2,3,5] === 12
console.log(fibSum(6)); // [1,1,2,3,5,8] === 20

```

--------

### First Even Number

```js
//return the sum of the first n even numbers recursively. Assume n > 0

function firstEvenNumbersSum(n) {
  if (n === 1) return 2;
  return n * 2 + firstEvenNumbersSum(n - 1);
}

console.log(firstEvenNumbersSum(1)); // 2
console.log(firstEvenNumbersSum(3)); // 2 + 4 + 6 = 12
console.log(firstEvenNumbersSum(6)); // 2 + 4 + 6 + 8 + 10 + 12 = 42

```


-------
### Inherits

```js
// We've learned a couple of ways to implement class inheritance
// in Javascript. Let's first look at using a Surrogate.
//
// There are a number of steps:

// Define a Surrogate class
// Set the prototype of the Surrogate (Surrogate.prototype = SuperClass.prototype)
// Set Subclass.prototype = new Surrogate()
// Set Subclass.prototype.constructor = Subclass

// Write a Function.prototype.inherits method that will do this for you.
//Do not use Object.create right now; you should deeply understand
//what the new keyword does and how the __proto__ chain is constructed.

//----------------------------
// Using Surrogate
//----------------------------

Function.prototype.inherits1 = function(BaseClass) {
  function Surrogate() {}
  Surrogate.prototype = BaseClass.prototype;
  this.prototype = new Surrogate();

  // otherwise instances of this will have 'instance.prototype.constructor === BaseClass'
  this.prototype.constructor = this;
};

//----------------------------
// Using Object.Create
//----------------------------

// After you have written Function.prototype.inherits
// using the surrogate trick, refactor your solution using
// Object.create. Make sure to test that your updated solution works.

Function.prototype.inherits2 = function(ParentClass) {
  this.prototype = Object.create(ParentClass.prototype);
  this.prototype.constructor = this;
};

//----------------------------
// Test
//----------------------------

function Dog(name) {
  this.name = name;
}

Dog.prototype.bark = function() {
  console.log(this.name + ' barks!');
};

function Corgi(name) {
  Dog.call(this, name);
}

Corgi.inherits1(Dog); // change to inherits2 to test your second method

Corgi.prototype.waddle = function() {
  console.log(this.name + ' waddles!');
};

const blixa = new Corgi('Blixa');
blixa.bark(); // Blixa barks!
blixa.waddle(); // Blixa waddles!

function Shepherd(name) {
  Dog.call(this, name);
}

Shepherd.inherits2(Dog); // change to inherits2 to test your second method

Shepherd.prototype.waddle = function() {
  console.log(this.name + ' waddles!');
};

const blixa2 = new Shepherd('Blixa2');
blixa2.bark(); // Blixa2 barks!
blixa2.waddle(); // Blixa2 waddles!

```


-------

### Jumble Sort

```js
// Jumble sort takes a string and an alphabet. It returns a copy of the string
// with the letters re-ordered according to their positions in the alphabet. If
// no alphabet is passed in, it defaults to normal alphabetical order (a-z).
//
// Example:
// jumbleSort("hello") => "ehllo"
// jumbleSort("hello", ['o', 'l', 'h', 'e'])  // 'ollhe'

const jumbleSort = (str, alpha = 'abcdefghijklmnopqrstuvwxyz') => {
  return str
    .split('')
    .sort((a, b) => alpha.indexOf(a) - alpha.indexOf(b))
    .join('');
};

console.log(jumbleSort('hello')); // ehllo
```


--------

### Median

```js
// Write a method that returns the median of elements in an array
// If the length is even, return the average of the middle two elements

Array.prototype.median = function() {
  if (this.length === 0) return;
  const mid = Math.floor(this.length / 2);
  let arr = this.sort();

  if (this.length % 2 === 1) return arr[mid];
  else return (arr[mid - 1] + arr[mid]) / 2;
};

console.log([1, 2, 3, 4, 5, 6].median()); // 3.5
console.log([1, 2, 3, 4, 5].median()); // 3
console.log([3, 2, 6, 7].median()); // 4.5
console.log([3, 2, 6, 7, 1].median()); // 3
console.log([].median()); // undefined


```


--------

### Merge Sort

```js
//Write an Array#merge_sort method; it should not modify the original array.
// If a comparator is passed, it should sort according to that callback.

//SORT SKELETON

Array.prototype.mergeSort = function(comp) {
  if (this.length <= 1) return this;

  if (typeof comp !== 'function') {
    comp = (a, b) => {
      if (a === b) return 0;
      if (a > b) return 1;
      return -1;
    };
  }

  const mid = Math.floor(this.length / 2);

  const left = this.slice(0, mid).mergeSort(comp);
  const right = this.slice(mid).mergeSort(comp);

  return merge(left, right, comp);
};

function merge(left, right, comp) {
  const result = [];

  while (left.length > 0 && right.length > 0) {
    const op = comp(left[0], right[0]);
    if (op < 1) {
      result.push(left.shift());
    } else {
      result.push(right.shift());
    }
  }

  return result.concat(left, right);
}

// FIN !!!

const compA = (a, b) => {
  console.log('hello');
  if (a < b) {
    return -1;
  } else if (a > b) {
    return 1;
  } else {
    return 0;
  }
};

const reversed = (x, y) => {
  if (x < y) {
    return 1;
  } else if (x > y) {
    return -1;
  } else {
    return 0;
  }
};

console.log([1, 9, 2, 3, 3, 0, 5, 6, 43, 3, 24].mergeSort()); // ONE WITHOUT
console.log([1, 9, 2, 3, 3, 0, 5, 6, 43, 3, 24, 15].mergeSort(compA)); // ONE WITH COMPARATOR
console.log([1, 9, 2, 3, 3, 0, 5, 6, 43, 3, 24, 15, 17].mergeSort(reversed)); // ONE WITH COMPARATOR REVERSED

```


---------


### My Bind

```js
// Write your myBind method so that it can take both
// bind-time arguments and call-time arguments.
// pt 1 is the ANTI fat arrow method;

Function.prototype.myBind1 = function(ctx) {
  const that = this;
  const bindArgs = Array.from(arguments).slice(1);

  return function() {
    const callArgs = Array.from(arguments);
    return that.apply(ctx, bindArgs.concat(callArgs));
  };
};

Function.prototype.myBind2 = function(ctx, ...bindArgs) {
  return (...callArgs) => {
    return this.apply(ctx, bindArgs.concat(callArgs));
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

// bind time args are "meow" and "Kush", no call time args
markov.says.myBind2(breakfast, 'meow', 'Kush')();
markov.says.myBind1(breakfast, 'meow', 'Kush')();
// Breakfast says meow to Kush!
// true

// no bind time args (other than context), call time args are "meow" and "a tree"
markov.says.myBind2(breakfast)('meow', 'a tree');
markov.says.myBind1(breakfast)('meow', 'a tree');
// Breakfast says meow to a tree!
// true

// bind time arg is "meow", call time arg is "Markov"
markov.says.myBind2(breakfast, 'meow')('Markov');
markov.says.myBind1(breakfast, 'meow')('Markov');
// Breakfast says meow to Markov!
// true

//  no bind time args (other than context), call time args are "meow" and "me"
const notMarkovSays2 = markov.says.myBind2(breakfast);
notMarkovSays2('meow', 'me');
const notMarkovSays1 = markov.says.myBind1(breakfast);
notMarkovSays1('meow', 'me');
// Breakfast says meow to me!
// true

// alright. WHAT THE EFF do we have going on here?
// we have to capture this in fn, becasue of scope.
// this doesnt persist!!
// we have to captture bindArgs for the same reason
//dont forget about Array.from!!!
// then, inside the function, we grab the SECOND group of args
// the args that are passed to the callback
//and then we simply return w/ apply like usual!

// when using the ... op, things are going to be differne
//1. ...args are already in an array
//2. fat arrow ALLOWS the shit to persist. (so no 'fn')

```

--------

### My Every

```js
// in JAvascript Array.every is essesntially Ruby's Array.all

Array.prototype.myForEach = function(cb) {
  for (let i = 0; i < this.length; i++) {
    cb(this[i]);
  }
};

Array.prototype.myEvery = function(cb) {
  for (let i = 0; i < this.length; i++) {
    if (!cb(this[i])) return false;
  }

  return true;
};

// Tester Callback
function isBigEnough(num) {
  return num >= 10;
}

const test = [10, 11, 12, 13].myEvery(isBigEnough); // true
const test2 = [11, 12, 13, 9, 10].myEvery(isBigEnough); // false

console.log(test); // true
console.log(test2); // false

```

--------

### My Flatten

```js
// Takes a multi-dimentional array and returns a single array of all the elements

Array.prototype.myForEach = function(cb) {
  for (let i = 0; i < this.length; i++) {
    cb(this[i]);
  }
  return;
};

Array.prototype.myFlatten = function() {
  let result = [];

  this.forEach(el => {
    if (el instanceof Array) result = result.concat(el.myFlatten(el));
    else result.push(el);
  });
  return result;
};

const testerMyFlatten = [1, [2, 3, [[['a'], 6]]], [4, [5]]].myFlatten(); // [1,2,3,'a',6,4,5]
console.log(testerMyFlatten);

// Write a version of flatten that only flattens n levels of an array.
// E.g. If you have an array with 3 levels of nested arrays, and run
// my_flatten(1), you should return an array with 2 levels of nested
// arrays

Array.prototype.myControlledFlatten = function(n) {
  if (n <= 0) return this;
  let result = [];

  for (let i = 0; i < this.length; i++) {
    if (this[i] instanceof Array && n > 0) {
      result = result.concat(this[i].myControlledFlatten(n - 1));
    } else {
      result.push(this[i]);
    }
  }

  return result;
};
// const tester = [1,[2,3], [4,[5]]].myControlledFlatten(5); // [1,2,3,4,[5]]
//
const testerTwoDeep = [1, [2, 3, [[['a'], 6]]], [4, [5]]].myControlledFlatten(
  2
); // [1,2,3,[["a"], 6], 4,5]
const testerThreeDeep = [1, [2, 3, [[['a'], 6]]], [4, [5]]].myControlledFlatten(
  3
); // [1,2,3,["a"], 6, 4,5]
console.log(testerTwoDeep);
console.log(testerThreeDeep);
```


---------

### My ForEach

```js
Array.prototype.myForEach = function(cb) {
  for (let i = 0; i < this.length; i++) {
    cb(this[i]);
  }
  return;
};

console.log(
  [1, 2, 3, 4].myForEach(function(el) {
    console.log(el + 1);
  })
); // 2, 3, 4, 5

```


-----------

### My Inject

```js
// Monkey patch the Array class and add a myInject method.
// In the JS exercises, you are required to use myForEach.
// So make sure you can write this for forEach opposed to a for loop!

Array.prototype.myForEach = function(cb) {
  for (i = 0; i < this.length; i++) {
    cb(this[i]);
  }
  return;
};

Array.prototype.myInject = function(cb) {
  let accum = this.shift();

  this.myForEach(e => (accum = cb(accum, e)));

  return accum;
};

//tester callback
let test = [1, 2, 3, 4].myInject(function(a, b) {
  return a + b;
});
let testMinus = [1, 2, 3, 4].myInject(function(a, b) {
  return a - b;
});
console.log(test); // 10
console.log(testMinus); // -8


```


----------

### My Join

```js
// Add your own myJoin to the ArrayClass. If no arg is given,
// set the separator to "".

Array.prototype.myJoin = function(separator) {
  if (separator === undefined) separator = '';

  let result = '';

  for (let i = 0; i < this.length - 1; i++) {
    result += this[i] + separator;
  }
  result += this.slice(-1);
  return result;
};

console.log([1, 2, 3].myJoin());
console.log(['javascript', 'is', 'weird'].myJoin(' '));

```


--------

### My Merge

```js
//so basically, override the key if obj1 key exists, other wise tack it on the end;
// destructive
function myMerge1(obj1, obj2) {
  Object.keys(obj2).forEach(key => {
    obj1[key] = obj2[key];
  });

  return obj1;
}

// doesn't modify origial hashes
function myMerge2(obj1, obj2) {
  const merged = {};

  Object.keys(obj1).forEach(key => {
    if (!Object.keys(merged).includes(key)) {
      merged[key] = obj1[key];
    }
  });

  Object.keys(obj2).forEach(key => {
    if (!Object.keys(merged).includes(key)) {
      merged[key] = obj2[key];
    }
  });

  return merged;
}

const obj1 = { a: 1, b: 2, c: 3 };
const obj2 = { a: 1, b: 3, d: 4 };
console.log(myMerge1(obj1, obj2));
console.log(myMerge2(obj1, obj2));
// {a: 1, b: 3, c: 3, d: 4}

```


--------

### My Reject

```js
Array.prototype.myReject = function(cb) {
  const result = [];

  this.forEach(el => {
    if (!cb(el)) result.push(el);
  });

  return result;
};

//tester callback
function lessThan10(num) {
  return num < 10;
}

console.log([1, 2, 3, 4, 12, 13, 14].myReject(lessThan10));
// [12, 13, 14]

```


--------

### My Reverse

```js
Array.prototype.myReverse1 = function() {
  const result = [];
  while (this.length > 0) {
    result.push(this.pop());
  }

  return result;
};

Array.prototype.myReverse2 = function() {
  if (this.length === 1) return this;

  return this.slice(1).myReverse2().concat([this[0]]);
};

console.log([1, 2, 3, 4].myReverse1());
console.log([1, 2, 3, 4].myReverse2());

```

------------

### My Rotation

```js
Array.prototype.myRotate = function(num) {
  let n = num % this.length;

  return this.slice(n).concat(this.slice(0, n));
};

console.log([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11].myRotate(2));
// [ 3, 4, 5, 6, 7, 8, 9, 10, 11, 1, 2 ]

console.log([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11].myRotate(-2));
// [ 10, 11, 1, 2, 3, 4, 5, 6, 7, 8, 9 ]

```


--------

### My Select

```js
Array.prototype.myForEach = function(cb) {
  for (i = 0; i < this.length; i++) {
    cb(this[i]);
  }
  return;
};

Array.prototype.mySelect = function(cb) {
  const result = [];

  this.myForEach(el => {
    if (cb(el)) result.push(el);
  });

  return result;
};

//tester callback
function lessThan10(num) {
  return num < 10;
}
function moreThan10(num) {
  return num > 10;
}

console.log([1, 2, 3, 4, 10, 12, 13, 14].mySelect(lessThan10)); // 1, 2, 3, 4
console.log([1, 2, 3, 4, 10, 12, 13, 14].mySelect(moreThan10)); // 12, 13, 14

```



------

### My Some

```js
// in Javascript Array.some is essesntially Ruby's Array.any

Array.prototype.myForEach = function(cb) {
  for (i = 0; i < this.length; i++) {
    cb(this[i]);
  }
  return;
};

Array.prototype.mySome1 = function(cb) {
  for (let i = 0; i < this.length; i++) {
    if (cb(this[i])) return true;
  }

  return false;
};

Array.prototype.mySome2 = function(cb) {
  let some = false;

  this.myForEach(el => {
    if (cb(this[i])) {
      some = true;
    }
  });

  return some;
};

// Tester Callback
function isBigEnough(num) {
  return num >= 10;
}

const test = [11, 2, 3].mySome1(isBigEnough); // true
const test2 = [1, 2, 3].mySome1(isBigEnough); // false
const test3 = [11, 2, 3].mySome2(isBigEnough); // true
const test4 = [1, 2, 3].mySome2(isBigEnough); // false

console.log(test); // true
console.log(test2); // false
console.log(test3); // true
console.log(test4); // false

```


---------

### My Tranpose

```js
Array.prototype.myTranspose = function() {
  const cols = Array.from(
    { length: this[0].length },
    () => Array.from({ length: this.length })
  );

  for(let i = 0; i < this.length; i++){
    for(let j = 0; j < this[i].length; j++) {
      cols[j][i] = this[i][j];
    }
  }

  return cols;
};

console.log([[0, 1, 2], [3, 4, 5], [6, 7, 8]].myTranspose());
//[ [ 0, 3, 6 ], [ 1, 4, 7 ], [ 2, 5, 8 ] ]
```


-------

### My Zip

```js
Array.prototype.myZip = function(...arrays) {
  let result = [];

  for (let i = 0; i < this.length; i++) {
    let subArr = [this[i]];

    for (let j = 0; j < arrays.length; j++) {
      subArr.push(arrays[j][i]);
    }

    result.push(subArr);
  }

  return result;
};

console.log([1, 2, 3].myZip([4, 5, 6], [7, 8, 9])); // [[1,4,7], [2,5,8], [3,6,9]]
console.log([4, 5, 6].myZip([1, 2], [8])); // [[4,1,8], [5,2, undefined], [6, undefined, undefined]]

```


--------

### Prime

```js
// return the first n prime numbers.

const isPrime = num => {
  if (num === 1) return false
  for (let i = 2; i <= Math.sqrt(num); i++) {
    if (num % i === 0) return false;
  }

  return true;
};

const primes = n => {
  if (n === 0) return [];
  if (n === 1) return [2];

  const result = [2];
  let i = 3;

  while (result.length < n) {
    if (isPrime(i)) result.push(i);
    i++;
  }

  return result;
};

console.log(primes(4)); // [2,3,5,7]

```

-----------


### Prime Factorization

```js
// Write a recursive function that returns the prime factorization of
// a given number. Assume num > 1

function isPrime(n) {
  if (n === 1) return false;
  for (let i = 2; i < n; i++) {
    if (n % i === 0) return false;
  }

  return true;
}

const primeFactorization = num => {
  if (num === 1) return [];
  if (num === 2) return [2];

  let i = 2;
  while (!(isPrime(i) && num % i === 0)) {
    i++;
  }

  let result = [i];
  return result.concat(primeFactorization(num / i));
};

console.log(primeFactorization(12)); // [2,2,3]
console.log(primeFactorization(600851475143)); // [71,839,1471,6857]

```


---------

### Quick Sort

```js
//Hint: quickSort checks by pivoting!
//Hint 2: The solution is a bit different than the solution in Ruby!

Array.prototype.quickSort = function(comp) {
  if (this.length < 2) return this;

  if (typeof comp !== 'function') {
    comp = (x, y) => {
      if (x === y) return 0;
      if (x > y) return 1;
      return -1;
    };
  }

  const pivot = this[0];

  const left = [];
  const right = [];

  for (let i = 1; i < this.length; i++) {
    const op = comp(pivot, this[i]);

    if (op === 1) left.push(this[i]);
    else right.push(this[i]);
  }

  return left.quickSort(comp).concat(pivot, right.quickSort(comp));
};

// this call back is essentially the prc we would pass in ruby.

const compA = (a, b) => {
  if (a > b) {
    return 1;
  } else if (a < b) {
    return -1;
  } else {
    return 0;
  }
};

const reversed = (x, y) => {
  if (x < y) {
    return 1;
  } else if (x > y) {
    return -1;
  } else {
    return 0;
  }
};

const testNoComp = [7, 3, 5, 2, 8, 1, 9, 3, 4].quickSort();
const testWithComp = [7, 3, 5, 2, 8, 1, 9, 3, 4].quickSort(compA);
const testReverse = [7, 3, 5, 2, 8, 1, 9, 3, 4].quickSort(reversed);
console.log(testNoComp);
console.log(testWithComp);
console.log(testReverse);

```


---------

### Range

```js
// range(start, end) - receives a start and end value,
// returns an array from start up to end. Use recursion!
function range(start, end) {
  if (start === end) return end;

  return [start].concat(range(++start, end));
}
console.log(range(3, 10));

```


---------

### Real Words in String

```js
// Returns an array of all the subwords of the string that appear in the
// dictionary argument. The method does NOT return any duplicates.

String.prototype.realWords = function(dictionary) {
  const result = [];

  for (let i = 0; i < this.length - 1; i++) {
    for (let j = i + 1; j < this.length; j++) {
      const substring = this.slice(i, j);
      if (!result.includes(substring) && dictionary.includes(substring))
        result.push(substring);
    }
  }

  return result;
};

console.log('asdfcatqwer'.realWords(['cat', 'car'])); // ['cat']
console.log('batcabtarbrat'.realWords(['cat', 'car'])); // []
console.log('erbearsweatmyajs'.realWords(['bears', 'ear', 'a', 'army']));
// ["bears", "ear", "a"]

```

-------

### Recursive Sum

```js
//Write a recursive method that returns the sum of all elements in an array
const recSum = nums => {
  if (nums.length < 2) return nums[0];

  return nums[0] + recSum(nums.slice(1));
};

console.log(recSum([5, 45, 7])); // 57
console.log(recSum([1, 2, 3])); // 6

```
