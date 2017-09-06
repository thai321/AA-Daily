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

const FollowToggle = __webpack_require__(1);
const UsersSearch = __webpack_require__(3);

$(() => {
  //callback
  // buttions
  $buttons = $('button');
  $buttons.each((idx, button) => {
    const follow = new FollowToggle($(button));
  });

  // users search

  $userNavs = $('nav.users-search');
  $userNavs.each((idx, userNav) => {
    const user = new UsersSearch($(userNav));
  });
});


/***/ }),
/* 1 */
/***/ (function(module, exports, __webpack_require__) {

const APIUtil = __webpack_require__(2);

class FollowToggle {
  constructor($el, options) {
    this.$el = $el;
    this.userId = $el.data('user-id') || options.userId;
    this.followState = $el.data('initial-follow-state') || options.followState;
    this.followState = this.followState.toString();
    this.render();
    this.$el.on('click', this.handleClick.bind(this));
  }

  handleClick(event) {
    event.preventDefault();
    this.$el.attr('disabled', true);
    const success = state => {
      this.followState = state;
      this.render();
    };

    if (this.followState !== 'true') {
      APIUtil.followUser(this.userId).then(() => success('true'));
    } else {
      APIUtil.unfollowUser(this.userId).then(() => success('false'));
    }
  }

  render() {
    const content = this.followState === 'true' ? 'unfollow' : 'follow';
    this.$el.text(content);
    this.$el.attr('disabled', false);
  }
}

module.exports = FollowToggle;


/***/ }),
/* 2 */
/***/ (function(module, exports) {

const APIUtil = {
  followUser: id => {
    return $.ajax({
      url: `http://localhost:3000/users/${id}/follow`,
      method: 'POST',
      dataType: 'JSON'
    });
  },

  unfollowUser: id => {
    return $.ajax({
      url: `http://localhost:3000/users/${id}/follow`,
      method: 'DELETE',
      dataType: 'JSON'
    });
  },

  searchUsers: (queryVal, success) => {
    return $.ajax({
      url: `http://localhost:3000/users/search?query=${queryVal}`,
      dataType: 'JSON',
      success: success
    });
  }
};

module.exports = APIUtil;


/***/ }),
/* 3 */
/***/ (function(module, exports, __webpack_require__) {

const APIUtil = __webpack_require__(2);
const FollowToggle = __webpack_require__(1);

class UsersSearch {
  constructor($el) {
    this.$el = $el;
    this.$input = $el.find('input'); // return collections
    this.$ul = $el.find('ul'); // return collections
    this.$input.on('input', this.handleInput.bind(this));
  }

  handleInput(event) {
    // console.log(event);
    const success = function success(data) {
      this.renderResults(data); //data is users search result
    };
    APIUtil.searchUsers(this.$input.val(), success.bind(this));
  }

  renderResults(users) {
    this.$ul.empty();
    users.forEach(user => {
      let $li = $(
        `<li><a HREF="http://localhost:3000/users/${user.id}" >${user.username}</a></li>`
      );

      let $button = $('<button>');
      const toggleButton = new FollowToggle($button, {
        userId: user.id,
        followState: user.followed
      });

      $li.append($button);
      this.$ul.append($li);
    });
  }
}

module.exports = UsersSearch;


/***/ })
/******/ ]);
//# sourceMappingURL=bundle.js.map