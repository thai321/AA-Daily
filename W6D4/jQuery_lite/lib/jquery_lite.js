/******/ (function(modules) { // webpackBootstrap
/******/ 	// The module cache
/******/ 	var installedModules = {};
/******/
/******/ 	// The require function
/******/ 	function __webpack_require__(moduleId) {
/******/
/******/ 		// Check if module is in cache
/******/ 		if(installedModules[moduleId]) {
/******/ 			return installedModules[moduleId].exports;
/******/ 		}
/******/ 		// Create a new module (and put it into the cache)
/******/ 		var module = installedModules[moduleId] = {
/******/ 			i: moduleId,
/******/ 			l: false,
/******/ 			exports: {}
/******/ 		};
/******/
/******/ 		// Execute the module function
/******/ 		modules[moduleId].call(module.exports, module, module.exports, __webpack_require__);
/******/
/******/ 		// Flag the module as loaded
/******/ 		module.l = true;
/******/
/******/ 		// Return the exports of the module
/******/ 		return module.exports;
/******/ 	}
/******/
/******/
/******/ 	// expose the modules object (__webpack_modules__)
/******/ 	__webpack_require__.m = modules;
/******/
/******/ 	// expose the module cache
/******/ 	__webpack_require__.c = installedModules;
/******/
/******/ 	// define getter function for harmony exports
/******/ 	__webpack_require__.d = function(exports, name, getter) {
/******/ 		if(!__webpack_require__.o(exports, name)) {
/******/ 			Object.defineProperty(exports, name, {
/******/ 				configurable: false,
/******/ 				enumerable: true,
/******/ 				get: getter
/******/ 			});
/******/ 		}
/******/ 	};
/******/
/******/ 	// getDefaultExport function for compatibility with non-harmony modules
/******/ 	__webpack_require__.n = function(module) {
/******/ 		var getter = module && module.__esModule ?
/******/ 			function getDefault() { return module['default']; } :
/******/ 			function getModuleExports() { return module; };
/******/ 		__webpack_require__.d(getter, 'a', getter);
/******/ 		return getter;
/******/ 	};
/******/
/******/ 	// Object.prototype.hasOwnProperty.call
/******/ 	__webpack_require__.o = function(object, property) { return Object.prototype.hasOwnProperty.call(object, property); };
/******/
/******/ 	// __webpack_public_path__
/******/ 	__webpack_require__.p = "";
/******/
/******/ 	// Load entry module and return exports
/******/ 	return __webpack_require__(__webpack_require__.s = 0);
/******/ })
/************************************************************************/
/******/ ([
/* 0 */
/***/ (function(module, exports, __webpack_require__) {

const DOMNodeCollection = __webpack_require__(1);

window.$l = function $l(arg) {
  if (arg instanceof HTMLElement) {
    let arr = Array.from(arg);

    return new DOMNodeCollection(arr);
  }
  let elementList = document.querySelectorAll(arg);

  return new DOMNodeCollection(Array.from(elementList));
};


/***/ }),
/* 1 */
/***/ (function(module, exports) {

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


/***/ })
/******/ ]);