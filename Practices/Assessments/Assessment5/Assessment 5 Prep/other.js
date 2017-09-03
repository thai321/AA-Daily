// Back in the good old days, you used to be able to write a darn near
// uncrackable code by simply taking each letter of a message and incrementing it
// by a fixed number, so "abc" by 2 would look like "cde", wrapping around back
// to "a" when you pass "z".  Write a function, `caesar_cipher(str, shift)` which
// will take a message and an increment amount and outputs the encoded message.
// Assume lowercase and no punctuation. Preserve spaces.
//
// To get an array of letters "a" to "z", you may use `("a".."z").to_a`. To find
// the position of a letter in the array, you may use `Array//find_index`.

function caesarCipher (str, shift) {

}

console.log('-------CAESAR CIPHER-------');
console.log(caesarCipher("aaa", 11) === "lll");
console.log(caesarCipher("zzz", 1) === "aaa");
console.log(caesarCipher("catz hatz", 2) === "ecvb jcvb");

// Write a method, `digital_root(num)`. It should Sum the digits of a positive
// integer. If it is greater than 10, sum the digits of the resulting number.
// Keep repeating until there is only one digit in the result, called the
// "digital root". **Do not use string conversion within your method.**
//
// You may wish to use a helper function, `digital_root_step(num)` which performs
// one step of the process.

function digitalRoot(num) {
  
}

console.log('-------DIGITAL ROOT-------');
console.log(digitalRoot(9) === 9);
console.log(digitalRoot(4322) === 2);


// Jumble sort takes a string and an alphabet. It returns a copy of the string
// with the letters re-ordered according to their positions in the alphabet. If
// no alphabet is passed in, it defaults to normal alphabetical order (a-z).

// Example:
// jumble_sort("hello") => "ehllo"
// jumble_sort("hello", ['o', 'l', 'h', 'e']) => 'ollhe'

function jumbleSort(str, alphabet){

}

console.log('-------JUMBLE SORT-------');
console.log(jumbleSort("hello") === "ehllo");


  // Write a method, `Array//two_sum`, that finds all pairs of positions where the
  // elements at those positions sum to zero.

  // ordering matters. I want each of the pairs to be sorted smaller index
  // before bigger index. I want the array of pairs to be sorted
  // "dictionary-wise":
  //   [0, 2] before [1, 2] (smaller first elements come first)
  //   [0, 1] before [0, 2] (then smaller second elements come first)

Array.prototype.twoSum = function () {

};


console.log('-------TWO SUM-------');
console.log([0, 1, 2, 0].twoSum() === [[0, 3]]);
console.log([0, 1, 2, 3].twoSum() === []);
console.log([5, -5, -5].twoSum() === [[0, 1], [0, 2]]);
console.log([5, -1, -5, 1].twoSum() === [[0, 2], [1, 3]]);


  // Returns an array of all the subwords of the string that appear in the
  // dictionary argument. The method does NOT return any duplicates.

String.prototype.realWordsInString = function (dictionary) {

};

String.prototype.subwords = function () {

};

console.log('-------REAL WORDS IN STRING-------');
let words = "asdfcatqwer".realWordsInString(["cat", "car"]);
console.log(words === ["cat"]);
let words2 = "batcabtarbrat".realWordsInString(["cat", "car"]);
console.log(words2 === []);
let dict = ["bears", "ear", "a", "army"];
let words3 = "erbearsweatmyajs".realWordsInString(dict);
console.log(words3 === ["bears", "ear", "a"]);


// Write a method that returns the factors of a number in ascending order.

function factors(num) {

}
console.log('-------FACTORS-------');
console.log(factors(10) === [1, 2, 5, 10]);
console.log(factors(13) === [1, 13]);

//////// Strings ////////

// Write a method that capitalizes each word in a string like a book title
// Do not capitalize words like 'a', 'and', 'of', 'over' or 'the'
function titleize(title) {

}

// Write a method that translates a sentence into pig latin. You may want a helper method.
// 'apple' => 'appleay'
// 'pearl' => 'earlpay'
// 'quick' => 'ickquay'
function translate (sentence) {

}

// Write a method that returns all substrings that are also palindromes
function symmetricSubstrings () {

}

// Missing Numbers
//
// Given an array of unique integers ordered from least to greatest, write a
// method that returns an array of the integers that are needed to
// fill in the consecutive set.

function missingNumbers (num) {

}

console.log("-------MISSING NUMBERS-------");
console.log(missingNumbers([1, 3]) === [2]);
console.log(missingNumbers([2, 3, 7]) === [4, 5, 6]);
console.log(missingNumbers([-5, -1, 0, 3]) === [-4, -3, -2, 1, 2]);
console.log(missingNumbers([100, 103, 105]) === [101, 102, 104]);
console.log(missingNumbers([0, 5]) === [1, 2, 3, 4]);

// Binary to Base 10
//
// Write a method that given a string representation of a binary number will
// return that binary number in base 10.
//
// To convert from binary to base 10, we take the sum of each digit multiplied by
// two raised to the power of its index. For example:
//   1001 = [ 1 * 2^3 ] + [ 0 * 2^2 ] + [ 0 * 2^1 ] + [ 1 * 2^0 ] = 9

function base2to10 (binary) {

}

console.log("-------BINARY TO BASE 10-------");
console.log(base2to10("10") === 2);
console.log(base2to10("01") === 1);
console.log(base2to10("0111") === 7);
console.log(base2to10("1100") === 12);
console.log(base2to10("1010101") === 85);

// Lucas Numbers
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

function lucasNumbers(n) {

}

console.log("-------LUCAS NUMBERS-------");
console.log(lucasNumbers(3) === 4);
console.log(lucasNumbers(5) === 11);
console.log(lucasNumbers(-4) === 7);
console.log(lucasNumbers(-3) === -4);
console.log(lucasNumbers(10) === 123);
console.log(lucasNumbers(-11) === -199);

// Longest Palindrome
//
// A palindrome is a word or sequence of words that reads the same backwards as
// forwards. Write a method that returns the longest palindrome in a given
// string. If there is no palindrome longer than two letters, return false.

function longestPalindrome(string) {

}

console.log("-------LONGEST PALINDROME-------");
console.log(longestPalindrome("aaabbabbacccccc") === 7);
console.log(longestPalindrome("palindrome") === false);
console.log(longestPalindrome("minimumreviver") === 7);
console.log(longestPalindrome("clairesaysamanaplanacanalpanama") === 21);
console.log(longestPalindrome("1818471174") === 6);
