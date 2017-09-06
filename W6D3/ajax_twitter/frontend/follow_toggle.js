const APIUtil = require('./api_util.js');

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
