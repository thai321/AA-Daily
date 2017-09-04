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
