///'Spec' helper methods - not exercises
Array.prototype.equals = function(arr) {
  if (arr.length !== this.length) return false;
  for (let i = 0; i < this.length; i++) {
    if (this[i] !== arr[i]) return false;
  }
  return true;
};

Array.prototype.nestedEquals = function(arr) {
  if (arr.length !== this.length) return false;
  for (let i = 0; i < this.length; i++) {
    for (let j = 0; j < this[i].length; j++) {
      if (this[i][j] !== arr[i][j]) return false;
    }
  }
  return true;
};

//////// Recursion ////////

//You have array of integers. Write a recursive solution to find the
//sum of the integers.

function sumRecur(array) {
  if (array.length == 0) return 0;
  return array[0] + sumRecur(array.slice(1));
}

console.log('-------SUM RECUR-------');
console.log(sumRecur([1, 3, 5, 7, 9, 2, 4, 6, 8]) === 45);
console.log(sumRecur([-3, 0, 3, 7, 1, 0, -7, 32]) === 33);
console.log(sumRecur([]) === 0);

//You have array of integers. Write a recursive solution to determine
//whether or not the array contains a specific value.

function includes(array, target) {}

console.log('-------INCLUDES-------');
console.log(includes([1, 3, 5, 7, 9, 2, 4, 6, 8], 9) === true);
console.log(includes([1, 3, 5, 7, 9, 2, 4, 6, 8], 11) === false);
console.log(includes([], 0) === false);

// You have an unsorted array of integers. Write a recursive solution
// to count the number of occurrences of a specific value.

function numOccur(array, target) {}

console.log('-------NUM OCCUR-------');
console.log(numOccur([1, 1, 2, 3, 4, 5, 5, 4, 5, 6, 7, 6, 5, 6], 5) === 4);
console.log(numOccur([1, 1, 2, 3, 4, 5, 5, 4, 5, 6, 7, 6, 5, 6], 13) === 0);

//You have array of integers. Write a recursive solution to determine
// whether or not two adjacent elements of the array add to 12.

function addToTwelve(array) {}

console.log('-------ADD TO TWELVE-------');
console.log(addToTwelve([1, 1, 2, 3, 4, 5, 7, 4, 5, 6, 7, 6, 5, 6]) === true);
console.log(addToTwelve([1, 1, 2, 3, 4, 5, 5, 4, 5, 6, 7, 6, 5, 6]) === false);

//You have array of integers. Write a recursive solution to determine
// if the array is sorted.

function sorted(array) {}

console.log('-------SORTED-------');
console.log(sorted([1]) === true);
console.log(sorted([]) === true);
console.log(sorted([1, 2, 3, 4, 4, 5, 6, 7]) === true);
console.log(sorted([1, 1, 2, 3, 4, 5, 5, 4, 5, 6, 7, 6, 5, 6]) === false);

//Write a recursive function to reverse a string. Don't use any
// built-in //reverse methods!

function reverse(string) {}

console.log('-------REVERSE-------');
console.log(reverse('') === '');
console.log(reverse('a') === 'a');
console.log(reverse('laozi') === 'izoal');
console.log(reverse('kongfuzi') === 'izufgnok');

// Write a recursive method that returns the first "num" factorial numbers.
function digitalRoot(num) {}

console.log('-------DIGITAL ROOT-------');
console.log(digitalRoot(9) === 9);
console.log(digitalRoot(4322) === 2);

// Write a recursive method that returns the factorial of num
function factorial(num) {}

console.log('-------FACTORIAL-------');
console.log(factorial(9) === 362880);
console.log(factorial(0) === 1);
console.log(factorial(1) === 1);

// Write a recursive method that returns an array of first n number of factorials
function factorialsRec(num) {}

//array comparison doesnt work :(
console.log('-------FACTORIALS REC-------');
console.log(
  factorialsRec(9).equals([1, 2, 6, 24, 120, 720, 5040, 40320, 362880])
);
console.log(factorialsRec(0).equals([]));
console.log(factorialsRec(1).equals([1]));

// Write a recursive method that returns an array of numbers between min and max
function range(min, max) {}

console.log('-------RANGE-------');
console.log(range(1, 9).equals([1, 2, 3, 4, 5, 6, 7, 8, 9]));
console.log(range(2, 1).equals([]));

// Write a function sumTo(n) that uses recursion to calculate the sum from
// 1 to n (inclusive of n).
function sumTo(n) {}

console.log('-------SUMTO-------');
console.log(sumTo(1) === 1);
console.log(sumTo(5) === 15);
console.log(sumTo(9) === 45);
console.log(sumTo(-8) === null);
console.log(sumTo(0) === 0);

// Write a recursive method that exponentiates base ** power without using the ** method
function exp(base, power) {}

console.log('-------EXP-------');
console.log(exp(0, 0) === 1);
console.log(exp(6, 7) === 279936);

// Write a recursive method that returns the first n number of fibonacci numbers in an array
function fibsRec(n) {}

console.log('-------FIBS REC-------');
console.log(fibsRec(1).equals([1]));
console.log(fibsRec(2).equals([1, 1]));
console.log(fibsRec(10).equals([1, 1, 2, 3, 5, 8, 13, 21, 34, 55]));

// Implement a method that finds the sum of the first n
// fibonacci numbers recursively. Assume n > 0
function fibsSum(n) {}

console.log('-------FIBS SUM-------');
console.log(fibsSum(1) === 1);
console.log(fibsSum(2) === 2);
console.log(fibsSum(10) === 143);

// Let's write a method that will solve Gamma Function recursively. The Gamma
// Function is defined Γ(n) = (n-1)!.

function gammaFnc(n) {}

console.log('-------GAMMA FNC-------');
console.log(gammaFnc(0) === null);
console.log(gammaFnc(1) === 1);
console.log(gammaFnc(4) === 6);
console.log(gammaFnc(8) === 5040);

// Write a recursive method that returns the sum of the first n even numbers
function firstEvenNumbersSum(n) {}

console.log('-------FIRST EVEN NUMBERS SUM-------');
console.log(firstEvenNumbersSum(0) === 0);
console.log(firstEvenNumbersSum(1) === 2);
console.log(firstEvenNumbersSum(5) === 30);

// Lucas Numbers RECURSION
//
// The Lucas series is a sequence of integers that extends infinitely in both
// positive and negative directions.
//
// The first two numbers in the Lucas series are 2 and 1. A Lucas number can
// be calculated as the sum of the previous two numbers in the sequence.
// A Lucas number can also be calculated as the difference between the next
// two numbers in the sequence.
//
// All numbers in the Lucas series are indexed. The number 2 is
// located at index 0. The number 1 is located at index 1, and the number -1 is
// located at index -1. You might find the chart below helpful:
//
// Lucas series: ...-11,  7,  -4,  3,  -1,  2,  1,  3,  4,  7,  11...
// Indices:      ... -5, -4,  -3, -2,  -1,  0,  1,  2,  3,  4,  5...
//
// Write a method that takes an input N and returns the number at the Nth index
// position of the Lucas series.

function lucasNumbersRecur(n) {}

console.log('-------LUCAS NUMBERS RECUR-------');
console.log(lucasNumbersRecur(3) === 4);
console.log(lucasNumbersRecur(-3) === -4);
console.log(lucasNumbersRecur(10) === 123);
console.log(lucasNumbersRecur(-11) === -199);

// Write a recursive method subsets that will return all subsets of an array.
function subsets(array) {}

console.log('-------SUBSETS-------');
console.log(subsets([]).nestedEquals([[]]));
console.log(
  subsets([1, 2, 3]).nestedEquals([
    [],
    [3],
    [2],
    [2, 3],
    [1],
    [1, 3],
    [1, 2],
    [1, 2, 3]
  ])
);

// Write a recursive method that returns all of the permutations of an array
function permutations(array) {}

console.log('-------PERMUTATIONS-------');
// console.log(permutations([1,2,3]).nestedEquals([[1, 2, 3], [1, 3, 2], [2, 1, 3], [2, 3, 1], [3, 2, 1], [3, 1, 2]]));

// Write a recursive method that returns an array of the best change given a target amouunt
function makeChange(target, coins = [25, 10, 5, 1]) {}
