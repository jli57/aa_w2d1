require "colorize"
require "singleton"

class Piece

  def initialize(color, board, pos)
    @color = color
    @board = board
    @pos = pos
  end

  def to_s
    "♞".colorize(@color)
  end

  def symbol
    :piece
  end

  def moves

  end

end

class NullPiece < Piece
  include Singleton
  def initialize

  end

  def moves

  end

  def symbol
    :null
  end

  def to_s
    " "
  end

end

class King < Piece

  def to_s
    "♚".colorize(@color)
  end

end

class Queen < Piece

  def to_s
    "♛".colorize(@color)
  end

end

class Rook < Piece

  def to_s
    "♜".colorize(@color)
  end

end

class Bishop < Piece

  def to_s
    "♝".colorize(@color)
  end
end

class Knight < Piece

  def to_s
    "♞".colorize(@color)
  end

end

class Pawn < Piece

  def to_s
    "♟".colorize(@color)
  end

end

module Slideable

end

module Stepable

end
