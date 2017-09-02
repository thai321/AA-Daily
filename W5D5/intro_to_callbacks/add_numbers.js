const readline = require("readline");

const reader = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});

function addNumbers(sum, numsLeft, completionCallback) {
  if (numsLeft > 0) {
    reader.question("Enter a number: ", function(inputString) {
      const num = parseInt(inputString);
      addNumbers(sum + num, numsLeft - 1, completionCallback);
    });
  } else {
    completionCallback(sum);
  }
}

function displayResult(sum) {
  console.log(`Result is ${sum}!`);
}

// addNumbers(0, 3, displayResult);
