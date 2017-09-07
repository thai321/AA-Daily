const DOMNodeCollection = require('./dom_node_collection.js');

window.$l = function $l(arg) {
  if (arg instanceof HTMLElement) {
    let arr = Array.from(arg);

    return new DOMNodeCollection(arr);
  }
  let elementList = document.querySelectorAll(arg);

  return new DOMNodeCollection(Array.from(elementList));
};
