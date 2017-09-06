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

var ChatMachine = __webpack_require__(1);

$(function() {
  new ChatMachine($('.chat'));
});


/***/ }),
/* 1 */
/***/ (function(module, exports) {

var ChatMachine = function($el) {
  this.$messages = $el.find('ul');
  this.$form = $el.find('form');
  this.$form.on('submit', this.submitMessage.bind(this));
};

ChatMachine.prototype.submitMessage = function(e) {
  e.preventDefault();
  // alert('nothing but the alert!');

  $.ajax({
    method: 'POST',
    url: '/messages',
    dataType: 'json',

    //payload(the body), key: message[author] -- val: its key's value
    //                   key: message[text] -- val: its key's value
    data: this.$form.serialize(),
    success: function(message) {
      this.addMessage(message);
      this.clearForm();
    }.bind(this)
  });
  this.addSpinner();
};

ChatMachine.prototype.addMessage = function(message) {
  const content = `${message.author}: ${message.text}`;
  const $message = $('<li>').text(content);
  this.$messages.append($message);
  this.$messages.find('.loader').remove();
};

ChatMachine.prototype.clearForm = function() {
  this.$form.find("input[type='text']").val('');
};

ChatMachine.prototype.addSpinner = function() {
  this.$messages.append('<div class="loader">Loading...</div>');
};

module.exports = ChatMachine;


/***/ })
/******/ ]);