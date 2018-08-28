require "colorize"

class Piece

  def initialize
    @color = :white
  end

  def to_s
    "♞".colorize(@color)
  end

  def symbol
    :piece
  end

end

class NullPiece < Piece


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
