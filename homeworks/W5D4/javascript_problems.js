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
