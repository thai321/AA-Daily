Array.prototype.bubbleSort = function(array) {
  let result = this;
  for (let i = 0; i < this.length - 1; i++) {
    for (let j = i + 1; j < this.length; j++) {
      if (result[i] > result[j]) {
        let temp = result[i];
        result[i] = result[j];
        result[j] = temp;
      }
    }
  }
  return result;
};

String.prototype.substrings = function() {
  let subs = [];
  for (let i = 0; i < this.length; i++) {
    for (let j = i; j < this.length; j++) {
      subs.push(this.slice(i, j + 1));
    }
  }

  return subs;
};
