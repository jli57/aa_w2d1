require "colorize"
require "singleton"
require "byebug"

class Piece
  attr_reader :color, :board, :pos
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

  def valid_moves
    #return array of valid moves
  end

  def empty?
    self.is_a?(NullPiece)
  end

  def pos=(val)
    @pos = val
  end

  private

  def move_into_check?(end_pos)

  end

end

class NullPiece < Piece
  include Singleton

  def initialize
  end

  def color
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

module SlidingPiece

  def moves
    result = []
    move_dirs.each do |offset|
      dx, dy = offset
      result += grow_unblocked_moves_in_dir(dx, dy)
    end
    result
  end

  def horizontal_dirs
    HORIZONTAL_DIRS
  end

  def diagonal_dirs
    DIAGONAL_DIRS
  end

  private

  HORIZONTAL_DIRS = [[-1, 0], [1, 0], [0, -1], [0, 1]]
  DIAGONAL_DIRS = [[-1, -1], [-1, 1], [1, 1],[1, -1]]

  def move_dirs

  end

  def grow_unblocked_moves_in_dir(dx, dy)
    result = []
    stop = false
    diff = [dx, dy]
    new_pos = @pos
    until stop
      new_pos = new_pos.map.with_index { |coord, idx| coord + diff[idx] }
      if @board.valid_pos?(new_pos) == false || @board[new_pos].color == self.color
        stop = true
      else
        result << new_pos
      end
    end
    result
  end

end

module SteppingPiece

  def moves

  end

  private

  HORIZONTAL_DIRS = [[-1, 0], [1, 0], [0, -1], [0, 1]]
  DIAGONAL_DIRS = [[-1, -1], [-1, 1], [1, 1],[1, -1]]

  def move_diffs

  end
end

class King < Piece
  include SteppingPiece

  def symbol
    :king
  end

  def to_s
    "♚".colorize(@color)
  end

end

class Queen < Piece
  include SlidingPiece

  def symbol
    :queen
  end

  def to_s
    "♛".colorize(@color)
  end

  def move_dirs
    horizontal_dirs + diagonal_dirs
  end

end

class Rook < Piece

  def symbol
    :rook
  end

  def to_s
    "♜".colorize(@color)
  end

  def move_dirs
    horizontal_dirs
  end

end

class Bishop < Piece

  def symbol
    :bishop
  end

  def to_s
    "♝".colorize(@color)
  end

  def move_dirs
    diagonal_dirs
  end

end

class Knight < Piece

  def symbol
    :knight
  end

  def to_s
    "♞".colorize(@color)
  end

end

class Pawn < Piece

  def symbol
    :pawn
  end

  def to_s
    "♟".colorize(@color)
  end

end
