``///'Spec' helper methods - not exercises
Array.prototype.equals = function (arr) {
  if (arr.length !== this.length) return false;
  for(let i = 0; i < this.length; i++) {
    if (this[i] !== arr[i]) return false;
  }
  return true;
};

Array.prototype.nestedEquals = function (arr) {
  if (arr.length !== this.length) return false;
  for(let i = 0; i < this.length; i++) {
    for(let j = 0; j < this[i].length; j++) {
      if (this[i][j] !== arr[i][j]) return false;
    }
  }
  return true;
};

//Write a method that squares each element in the array
Array.prototype.square = function () {

};

console.log('-------SQUARE-------');
console.log([1,2,3,4,5].square().equals([ 1, 4, 9, 16, 25 ]));


Array.prototype.myUniq = function () {

};

console.log('-------MY UNIQ-------');
console.log([1, 2, 6, 4, 'hi', 8, 4, 4, 6, 7, 2, 'hi'].myUniq().equals([1, 2, 6, 4, 'hi', 8, 7]));
console.log([].myUniq().equals([]));
console.log([1,2,3,4,5,6,7,8,9].myUniq().equals([1,2,3,4,5,6,7,8,9]));


Array.prototype.myJoin = function (j = ""){

};

console.log('-------MY JOIN-------');
console.log(['hi','how','are','you'].myJoin(" ") === 'hi how are you');
console.log(['hi','how','are','you'].myJoin() === 'hihowareyou');

// Write a method that returns the median of elements in an array
// If the length is even, return the average of the middle two elements

//dont forget to sort before running median mid -1 , not mid + 1
Array.prototype.median = function () {

};

console.log('-------MEDIAN-------');
console.log([2,3,1,4].median() === 2.5);
console.log([4,3,6,1,5,4,3,6,9].median() === 4);


Array.prototype.myTranspose = function () {

};

console.log('-------MY TRANSPOSE-------');
let rows = [
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8]
  ];
let cols = [
    [0, 3, 6],
    [1, 4, 7],
    [2, 5, 8]
  ];
console.log(rows.myTranspose().nestedEquals(cols));
console.log(cols.myTranspose().nestedEquals(rows));


Array.prototype.myReverse = function () {

};

console.log('-------MY REVERSE-------');
console.log([1,2,3,4,5].myReverse().equals([5,4,3,2,1]));

Array.prototype.myRotate = function (num = 1) {

};

console.log('-------MY ROTATE-------');
console.log([1,2,3,4,5].myRotate().equals([ 2, 3, 4, 5, 1 ]));
console.log([1,2,3,4,5].myRotate(5).equals([ 1, 2, 3, 4, 5 ]));
console.log([1,2,3,4,5].myRotate(3).equals([ 4, 5, 1, 2, 3 ]));

Array.prototype.myZip = function (...arrs){

};

// Write an Array#dups method that will return a hash containing the indices of all
// duplicate elements. The keys are the duplicate elements; the values are
// arrays of their indices in ascending order, e.g.
// [1, 3, 4, 3, 0, 3, 0].dups => { 3 => [1, 3, 5], 0 => [4, 6] }
Array.prototype.dups = function () {

};

///////ENUMERABLES///////////
Array.prototype.myEach = function (callback) {
  for(let i = 0; i < this.length; i++) {
    callback(this[i]);
  }
  return this;
};

//dunno how to test this lol
console.log('-------MY EACH-------');
let cb = (el) => console.log(`im working! num: ${el}`);
console.log([1,2,3,4,5].myEach(cb).equals([1,2,3,4,5]));


Array.prototype.myEachWithIndex = function (callback) {

};

console.log('-------MY EACH WITH INDEX-------');
let cb2 = (el, i) => console.log(`im working! num: ${el} index: ${i}`);
console.log([1,2,3,4,5].myEachWithIndex(cb2).equals([1,2,3,4,5]));


Array.prototype.mySelect = function (callback){

};


console.log('-------MY SELECT-------');
let cb3 = function (el) {
  return (el < 3);
};
console.log([1,2,3,4,5].mySelect(cb3).equals([1,2]));


Array.prototype.myReject = function (callback){

};

console.log('-------MY REJECT-------');
console.log([1,2,3,4,5].myReject(cb3).equals([3,4,5]));


Array.prototype.myAny = function (callback){

};

console.log('-------MY ANY-------');
let cb4 = (el) => {
  return el > 4;
};
console.log([1,2,3,4,5].myAny(cb4) === true);


Array.prototype.myAll = function (callback){

};

console.log('-------MY ALL-------');
let cb5 = (el) => {
  return el < 6;
};
let cb6 = (el) => {
  return el < 5;
};
console.log([1,2,3,4,5].myAll(cb5) === true);
console.log([1,2,3,4,5].myAll(cb6) === false);


Array.prototype.myInject = function (callback){

};

console.log('-------MY INJECT-------');
let cb7 = (acc, el) => {
  return acc + el;
};
console.log([1,2,3,4,5].myInject(cb7) === 15);

/////////SORTS AND SEARCHES/////////
Array.prototype.bubbleSort = function () {

};

console.log('-------BUBBLE SORT-------');
console.log([9,8,7,6,5,4,3,2,1].bubbleSort().equals([1,2,3,4,5,6,7,8,9]));
console.log([7,6,2,-3,8,4,5,3,9,1].bubbleSort().equals([-3,1,2,3,4,5,6,7,8,9]));


//Write a monkey patch of quick sort that accepts a callback
Array.prototype.myQuickSort = function (callback) {

};

console.log('-------MY QUICK SORT-------');
let cb8 = function (el, pivot) {
  if (el > pivot) {
    return 1;
  } else {
    return -1;
  }
};
console.log([9,8,7,6,5,4,3,2,1].myQuickSort(cb8).equals([1,2,3,4,5,6,7,8,9]));
console.log([7,6,2,-3,8,4,5,3,9,1].myQuickSort(cb8).equals([-3,1,2,3,4,5,6,7,8,9]));

Array.prototype.myBsearch = function (target){

};

console.log('-------MY BSEARCH-------');
console.log([1,2,3,4,5,6,7,8,9].myBsearch(1) === 0);
console.log([1,2,3,4,5,6,7,8,9].myBsearch(9) === 8);
console.log([1,2,3,4,5,6,7,8,9].myBsearch(4) === 3);
console.log([1,2,3,4,5,6,7,8,9].myBsearch(-3) === null);


Array.prototype.myMergeSort = function (callback) {

};

let merge = function (left, right, callback) {

};

console.log('-------MY MERGE SORT-------');
let cb9 = function (el1, el2) {
  if (el1 > el2) {
    return 1;
  } else {
    return -1;
  }
};
console.log([9,8,7,6,5,4,3,2,1].myMergeSort(cb9).equals([ 1, 2, 3, 4, 5, 6, 7, 8, 9 ]));
console.log([7,6,2,-3,8,4,5,3,9,1].myMergeSort(cb9).equals([ -3, 1, 2, 3, 4, 5, 6, 7, 8, 9 ]));

///////RECURSION///////
//Write a method that returns the sum of all elements in the array
Array.prototype.sum = function () {

};

console.log('-------SUM-------');
console.log([1, 3, 5, 7, 9, 2, 4, 6, 8].sum() === 45);
console.log([-3, 0, 3, 7, 1, 0, -7, 32].sum() === 33);
console.log([].sum() === 0);


Array.prototype.subsets = function () {

};

console.log('-------SUBSETS-------');
console.log([].subsets().nestedEquals([[]]));
console.log([1,2,3].subsets().nestedEquals([ [], [ 3 ], [ 2 ], [ 2, 3 ], [ 1 ], [ 1, 3 ], [ 1, 2 ], [ 1, 2, 3 ] ]));

// Takes a multi-dimentional array and returns a single array of all the elements
Array.prototype.myFlatten = function () {

};

console.log('-------MY FLATTEN-------');
console.log([1,[2,3], [4,[5]]].myFlatten().equals([1,2,3,4,5]));

// Write a version of flatten that only flattens n levels of an array.
// E.g. If you have an array with 3 levels of nested arrays, and run
// my_flatten(1), you should return an array with 2 levels of nested
// arrays
//
// [1,[2,3], [4,[5]]].my_controlled_flatten(1) => [1,2,3,4,[5]]
Array.prototype.myControlledFlatten = function (n) {

};
