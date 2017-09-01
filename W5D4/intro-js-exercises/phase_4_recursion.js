const range = (start, end) => {
  if (start === end) return [end];

  return [start].concat(range(start + 1, end));
};

const sumRec = arr => {
  if (arr.length === 0) return 0;

  return arr[0] + sumRec(arr.slice(1, arr.length));
};

const exponent1 = (base, exp) => {
  if (exp === 0) return 1;
  if (exp === 1) return base;

  return base * exponent1(base, exp - 1);
};

const exponent2 = (base, exp) => {
  if (exp === 0) return 1;
  if (exp === 1) return base;

  if (exp % 2 === 0) return Math.pow(exponent2(base, exp / 2), 2);
  if (exp % 2 === 1) return base * Math.pow(exponent2(base, (exp - 1) / 2), 2);
};

const fibonacci = n => {
  if (n === 0) return [];
  if (n === 1) return [0];
  if (n === 2) return [0, 1];

  let rec = fibonacci(n - 1);
  let last = [rec[rec.length - 2] + rec[rec.length - 1]];
  return rec.concat(last);
};

const bsearch = (array, target) => {
  if (array.length === 0) return -1;
  let middle = array.length / 2;

  if (array[middle] === target) {
    return middle;
  } else if (array[middle] > target) {
    return bsearch(array.slice(0, middle), target);
  } else {
    return bsearch(array.slice(middle, array.length), target) + middle;
  }
};

const mergeSort = arr => {
  if (arr.length === 0 || arr.length === 1) return arr;

  let middle = arr.length / 2;

  const mergedFirstHalf = mergeSort(arr.slice(0, middle));
  const mergedSecondHalf = mergeSort(arr.slice(middle, arr.length));

  return merge(mergedFirstHalf, mergedSecondHalf);
};

const merge = (arr1, arr2) => {
  const mergedArr = [];

  while (arr1.length >= 1 && arr2.length >= 1) {
    if (arr1[0] < arr2[0]) {
      mergedArr.push(arr1.shift());
    } else {
      mergedArr.push(arr2.shift());
    }
  }

  return mergedArr.concat(arr1).concat(arr2);
};

const subsets = arr => {
  if (arr.length === 0) return [arr];

  const first = [arr[0]];
  const rest = subsets(arr.slice(1, arr.length));
  const temp = rest.map(subArray => first.concat(subArray));

  return rest.concat(temp);
};
