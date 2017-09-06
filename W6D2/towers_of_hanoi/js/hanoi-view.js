class View {
  constructor(game, $el) {
    this.game = game;
    this.$el = $el;
    this.selected = false;

    this.setupTower();
    this.render();
    this.bindEvents();
  }

  bindEvents() {
    $('.pile').on('click', e => {
      const $pile = $(e.currentTarget);
      if (!this.selected) {
        $pile.attr('id', 'from-pile');
        this.selected = true;
        // console.log($("#from-pile").data("pile"));
      } else {
        const toIndex = $pile.data('pile');
        const fromIndex = $('#from-pile').data('pile');
        $('#from-pile').removeAttr('id');

        const tower = this.game.towers;
        console.log(tower[fromIndex].slice(-1));
        console.log(tower[toIndex].slice(-1));

        this.makeMove(fromIndex, toIndex);
        this.selected = false;
      }
    });
  }

  makeMove(fromIndex, toIndex) {
    if (this.game.move(fromIndex, toIndex)) {
      this.render();
      if (this.game.isWon()) alert('You win!');
    } else {
      alert('Invalid move, try Again');
    }
  }

  render() {
    $('ul').each((i, pile) => {
      const $pile = $(pile);
      $pile.empty();
      const tower = this.game.towers[i];
      for (let i = tower.length - 1; i >= 0; i--) {
        $pile.append(this.getDisk(tower[i]));
      }
    });
  }

  setupTower() {
    let i;
    for (i = 0; i < this.game.towers.length; i++) {
      const tower = this.game.towers[i];
      const $ul = $('<ul>').addClass('pile');
      $ul.data('pile', i);
      this.$el.append($ul);
    }
  }

  getDisk(i) {
    const $li = $('<li>');
    $li.addClass(`disk-${i}`);
    $li.data('disk', i);
    return $li;
  }
}

module.exports = View;
