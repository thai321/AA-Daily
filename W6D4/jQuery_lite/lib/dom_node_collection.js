class DOMNodeCollection {
  constructor(HTMLElements) {
    // this takes an Array
    this.HTMLElements = HTMLElements;
  }

  html(str) {
    let firstNode = this.HTMLElements[0];

    if (str === undefined) {
      return firstNode.innerHTML;
    } else {
      this.HTMLElements.forEach(element => {
        element.innerHTML = str;
      });
    }
  }

  empty() {
    this.HTMLElements.forEach(element => {
      element.innerHTML = '';
    });
  }

  append(arg) {
    if (arg instanceof HTMLElement) {
      this.HTMLElements.forEach(function(domEl) {
        domEl.innerHTML.append(arg.outerHTML);
      });
    } else {
      this.HTMLElements.forEach(function(domEl) {
        domEl.innerHTML += arg;
      });
    }
  }

  attr(name, value) {
    if (arguments.length > 1) {
      this.HTMLElements.forEach(el => {
        el.setAttribute(name, value);
      });
    } else {
      const result = [];
      this.HTMLElements.forEach(el => {
        if (el.getAttribute(name)) result.push(el.getAttribute(name));
      });

      return result;
    }
  }

  addClass(name) {
    this.HTMLElements.forEach(el => {
      el.classList.add(name);
    });
  }

  removeClass(name) {
    this.HTMLElements.forEach(el => {
      el.classList.remove(name);
    });
  }

  children() {
    let children = [];

    this.HTMLElements.forEach(el => {
      children.push(new DOMNodeCollection(el.childNodes));
    });

    return children;
  }

  parent() {
    let parents = [];

    this.HTMLElements.forEach(el => {
      parents.push(new DOMNodeCollection(el.parentElement));
    });

    return parents;
  }

  find(selector) {
    let found = [];
    debugger;
    this.HTMLElements.forEach(el => {
      const selections = el.querySelectorAll(selector);
      if (selections.length > 0) {
        found = found.concat(Array.from(selections));
      }
    });

    return found;
  }

  remove() {
    this.HTMLElements.forEach(el => {
      el.remove();
    });

    this.HTMLElements = [];
  }
}

module.exports = DOMNodeCollection;
