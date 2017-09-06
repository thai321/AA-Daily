class FollowToggle {
  constructor($el) {
    this.$el = $el;
    this.userId = $el.data('user-id');
    this.followState = $el.data('initial-follow-state').toString();
    this.render();
    this.$el.on('click', this.handleClick.bind(this));
  }

  handleClick(event) {
    event.preventDefault();
    if (this.followState !== 'true') {
      $.ajax({
        url: `http://localhost:3000/users/${this.userId}/follow`,
        method: 'POST',
        data: {
          user_id: this.userId
        },
        success: () => {
          this.followState = 'true';
          this.render();
        }
      });
    } else {
      $.ajax({
        url: `http://localhost:3000/users/${this.userId}/follow`,
        method: 'DELETE',
        data: {
          user_id: this.userId
        },
        success: () => {
          this.followState = 'false';
          this.render();
        }
      });
    }
  }

  render() {
    const content = this.followState === 'true' ? 'unfollow' : 'follow';
    this.$el.text(content);
  }
}

module.exports = FollowToggle;
