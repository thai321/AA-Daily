require 'byebug'
require 'colorize'
require_relative 'pieces'

class Piece
  attr_reader :type, :board, :code, :color
  attr_accessor :pos

  def initialize(pos, board, code, color)
    @pos = pos
    @board = board
    @code = code
    @color = color
  end

  def to_s
    symbol.to_s
  end

  def symbol
    code.encode('utf-8')
  end

  def call_moves
    moves
  end

  def empty?
    self.is_a? NullPiece : true : false
  end
end
