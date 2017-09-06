class View {
  constructor(game, $el) {
    this.game = game;
    this.$el = $el;

    this.setupBoard();
    this.bindEvents();
  }

  bindEvents() {
    $('.square').on('click', event => {
      // const $current = $(event.currentTarget);
      // const pos = $current.data("id");
      // alert(pos);
      if (this.game.isOver()) return;
      const $square = $(event.currentTarget);
      if (this.checkValid($square)) {
        this.makeMove($square);
      } else {
        alert('Invalid move');
      }
    });
  }

  makeMove($square) {
    this.game.playMove($square.data('pos'));
    $square.addClass(this.game.currentPlayer);
    $square.removeClass('unclicked');
    this.checkWinner();
  }

  checkWinner() {
    if (this.game.isOver()) {
      let text;
      if (this.game.winner()) text = this.game.winner() + 'wins!';
      else text = 'tie!';

      const $status = $('<div>' + text + '</div>');
      $('.ttt').append($status);
    }
  }

  checkValid($square) {
    return $square.hasClass('unclicked');
  }

  setupBoard() {
    const $ul = $('<ul>');
    $ul.addClass('group');

    for (let i = 0; i < 3; i++) {
      for (let j = 0; j < 3; j++) {
        const $square = $('<li>').addClass('square').addClass('unclicked');
        $square.data('pos', [i, j]);

        $ul.append($square);
      }
    }
    this.$el.append($ul);
  }
}

module.exports = View;
