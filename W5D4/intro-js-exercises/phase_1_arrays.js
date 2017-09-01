Array.prototype.uniq = function() {
  const uniqArray = [];
  this.forEach(el => {
    if (!uniqArray.includes(el)) uniqArray.push(el);
  });
  return uniqArray;
};

Array.prototype.twoSum = function() {
  const pairs = [];
  for (let i = 0; i < this.length - 1; i++) {
    for (let j = i + 1; j < this.length; j++) {
      if (this[i] + this[j] === 0) {
        pairs.push([i, j]);
      }
    }
  }
  return pairs;
};

Array.prototype.twoSumLinear = function() {
  const pairs = [];
  const memo = {};

  this.forEach((el, i) => {
    let target = el * -1;

    if (memo[target]) {
      let newPairs = memo[target].map(j => pairs.push([j, i]));
    }

    memo[el] ? memo[el].push(i) : (memo[el] = [i]);
  });

  return pairs;
};

Array.prototype.transpose = function() {
  var transformedArr = [...Array(this[0].length).keys()].map(i => Array());

  this.forEach(array => {
    array.forEach((el, i) => {
      transformedArr[i].push(el);
    });
  });

  return transformedArr;
};
