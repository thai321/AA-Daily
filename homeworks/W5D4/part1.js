console.log('----1-----');

function mysteryScoping1() {
  var x = 'out of block';
  if (true) {
    var x = 'in block';
    console.log(x);
  }
  console.log(x);
}
mysteryScoping1();

console.log('----2-----');

function mysteryScoping2() {
  const x = 'out of block';
  if (true) {
    const x = 'in block';
    console.log(x);
  }
  console.log(x);
}

mysteryScoping2();

console.log('----3-----');
function mysteryScoping3() {
  const x = 'out of block';
  if (true) {
    var x = 'in block';
    console.log(x);
  }
  console.log(x);
}

// mysteryScoping3(); raise error cause reassign 'const'
console.log('----4-----');

function mysteryScoping4() {
  let x = 'out of block';
  if (true) {
    let x = 'in block';
    console.log(x);
  }
  console.log(x);
}

mysteryScoping4();

function mysteryScoping5() {
  let x = 'out of block';
  if (true) {
    let x = 'in block';
    console.log(x);
  }
  let x = 'out of block again';
  console.log(x);
}

// mysteryScoping5(); raise error cause declare x using 'let' with
// the same name twice

console.log('-----------Mab Lib-----------');
/*
 Write a function that takes three strings - a verb, an adjective, and a noun -
  uppercases and interpolates them into the sentence "We shall VERB the
  ADJECTIVE NOUN". Use ES6 template literals.
*/
const madLib = (verb, adj, noun) => {
  let sentence = `We shall ${verb.toUpperCase()} the ${adj.toUpperCase()} ${noun.toUpperCase()}`;
  console.log(sentence);
};

madLib('make', 'best', 'guac');

console.log('--------------isSubstring---------------');

const isSubstring = (searchString, subString) =>
  searchString.includes(subString);

console.log(isSubstring('time to program', 'time')); // true

console.log(isSubstring('Jump for joy', 'joys')); // false

console.log('#######Phase II - JS Looping Constructs#######');

console.log('-------------fizzBuzz----------');
// Define a function fizzBuzz(array) that takes an array and
// returns a new array of every number in the array that is
// divisible by either 3 or 5, but not both
const fizzbuzz = arr => {
  let new_arr = [];
  for (x in arr) {
    if ((x % 3 || x % 5) && !(x % 3 && x % 5)) {
      new_arr.push(x);
    }
  }
  return new_arr;
};

let arr = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 15, 75];
console.log(fizzbuzz(arr));

console.log('-----isPrime--------');

const isPrime = num => {
  if (num == 0 || num == 1) return false;
  if (num == 2) return true;
  for (i = 2; i <= Math.sqrt(num); i++) {
    if (num % i == 0) return false;
  }
  return true;
};

console.log(isPrime(2));
console.log(isPrime(9));
console.log(isPrime(10));
console.log(isPrime(29));
console.log(isPrime(97));

console.log('-----sumOfNPrimes--------');
const sumOfNPrimes = n => {
  let count = 0;
  let sum = 0;
  let i = 2;

  while (count < n) {
    if (isPrime(i)) {
      sum += i;
      count++;
    }
    i++;
  }
  return sum;
};

console.log(sumOfNPrimes(0));
console.log(sumOfNPrimes(1));
console.log(sumOfNPrimes(4));
