const APIUtil = require('./api_util.js');

class TweetCompose {
  constructor($form, $ul) {
    this.$ul = $ul;
    this.$form = $form;
    this.$submit = this.$form.find('input[type=Submit]');
    this.$textarea = this.$form.find('textarea');
    this.$select = this.$form.find('select');
    this.$strongTag = this.$form.find('strong.chars-left');

    this.$form.on('submit', this.handleSubmit.bind(this));
    this.$textarea.on('input', this.handleInput.bind(this));
  }

  handleSubmit(event) {
    this.$submit.attr('disabled', true);
    event.preventDefault();
    APIUtil.createTweet(this.submit()).then(tweet => this.handleSuccess(tweet));
  }

  handleInput(event) {
    let chars_left = 140 - this.$textarea.val().length;
    console.log(chars_left);
    console.log(this.$strongTag);
    this.$strongTag.text(`${chars_left}`);
  }

  submit() {
    return {
      tweet: {
        content: this.$textarea.val(),
        mentioned_user_ids: [parseInt(this.$select.val())]
      }
    };
  }

  clearInput() {
    this.$textarea.val('');
    this.$select.val('');
  }

  handleSuccess(tweet) {
    this.clearInput();

    const content = tweet.content;
    const mention = tweet.mentions[0];

    console.log(tweet);
    let stringTweet = JSON.stringify(tweet);
    console.log(typeof stringTweet);
    console.log(stringTweet);
    let $li = $(`<li>${stringTweet}</li>`);
    this.$ul.append($li);
    this.$submit.attr('disabled', false);
  }
}

module.exports = TweetCompose;
