module SteppingPiece

  KNIGHT = [
    [2, 1],
    [2, -1],
    [-2, -1],
    [-2, 1],
    [1, 2],
    [1, -2],
    [-1, -2],
    [-1, -2]
  ]

  KING = [
      [1,0],
      [-1,0],
      [0, 1],
      [0, -1],
      [1, 1],
      [1, -1],
      [-1, -1],
      [-1, 1]
  ]

  def moves_dir
    if self.is_a?(Knight)
      KNIGHT
    elsif self.is_a?(King)
      KING
    end
  end

  def moves # returns an array of places a Piece can move to
    x, y = @pos
    moves = []

    moves_dir.each do |dir|
      dx, dy = dir

      x_new = x + dx
      y_new = y + dy
      unless !@board[[x_new, y_new]].is_a?(NullPiece)
        moves << [x_new, y_new] if x_new.between?(0, 7) && y_new.between?(0, 7)
      end
    end

    moves
  end
end
