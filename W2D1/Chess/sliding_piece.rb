module SlidingPiece

  HORIZONTAL = [
    [1,0],
    [-1,0]
  ]

  VERTICAL = [
    [0, 1],
    [0, -1]
  ]

  DIAGONAL = [
    [1,1],
    [1, -1],
    [-1, -1],
    [-1, 1]
  ]

  def moves_dir
    if self.is_a?(Bishop)
      DIAGONAL
    elsif self.is_a?(Rook)
      HORIZONTAL + VERTICAL
    elsif self.is_a?(Queen)
      HORIZONTAL + VERTICAL + DIAGONAL
    end
  end


  def moves # returns an array of places a Piece can move to
    x, y = @pos
    current_piece = @board[@pos]
    moves = []

    moves_dir.each do |dir|
      dx, dy = dir

      x_new = x + dx
      y_new = y + dy
      until !@board[[x_new, y_new]].is_a?(NullPiece)
        moves << [x_new, y_new] if x_new.between?(0, 7) && y_new.between?(0, 7)

        x_new += dx
        y_new += dy
      end
      new_pos = [x_new, y_new]
      moves << new_pos if !@board[new_pos].nil? && @board[new_pos].color != current_piece.color
    end

    moves
  end


end
