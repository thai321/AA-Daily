require 'byebug'
class Pawn < Piece
  attr_reader :has_moved

  def initialize(pos, board, code, color)
    @has_moved = false
    super
  end

  def moves
    x, y = pos

    moves_dir = []
    if code == "\u265F" # black pawn
      if has_moved
        moves_dir <<  [1, 0]
      else
        moves_dir += [[1,0], [2,0]]
      end
    else # white pawn
      if has_moved
        moves_dir << [-1, 0]
      else
        moves_dir += [[-1, 0], [-2, 0]]
      end

    end

    moves = []

    moves_dir.each do |dir|
      dx, dy = dir

      x_new = x + dx
      y_new = y + dy
      unless !@board[[x_new, y_new]].is_a?(NullPiece)
        moves << [x_new, y_new] if x_new.between?(0, 7) && y_new.between?(0, 7)
      end
    end

    if self.color == :black #black pawn takes
      moves << [x+1, y-1] if @board[[x + 1, y - 1]].color == :white
      moves << [x+1, y+1] if @board[[x + 1, y + 1]].color == :white
    #white pawn takes
    elsif self.color == :white
      moves << [x-1, y-1] if @board[[x - 1, y - 1]].color == :black
      moves << [x-1, y+1] if @board[[x - 1, y + 1]].color == :black
    end



    moves
  end
end
