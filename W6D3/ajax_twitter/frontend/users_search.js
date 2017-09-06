const APIUtil = require('./api_util.js');
const FollowToggle = require('./follow_toggle.js');

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
