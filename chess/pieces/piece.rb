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
    self.moves
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

  def other_color
    return :black if self.color == :white
    return :white if self.color == :black
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
      elsif @board[new_pos].color == other_color
        result << new_pos 
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
    result = []
    move_diffs.each do |diff|
      new_pos = @pos.map.with_index { |coord, idx| coord + diff[idx] }
      unless @board.valid_pos?(new_pos) == false || @board[new_pos].color == self.color
        result << new_pos
      end
    end
    result
  end

  private

  def move_diffs
    [[-1, 0], [1, 0], [0, -1], [0, 1], [-1, -1], [-1, 1], [1, 1],[1, -1]]
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

  def move_diffs
    [[-1, 0], [1, 0], [0, -1], [0, 1], [-1, -1], [-1, 1], [1, 1],[1, -1]]
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
  include SlidingPiece

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
  include SlidingPiece

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
  include SteppingPiece

  def symbol
    :knight
  end

  def to_s
    "♞".colorize(@color)
  end

  def move_diffs
    [[1,2], [2,1], [1,-2], [-2,1], [-1,2], [2, -1], [-1,-2], [-2,-1]]
  end

end

class Pawn < Piece

  def symbol
    :pawn
  end

  def move_dirs
    if self.color == :white
      [[-1, 0], [-1,-1], [-1, 1]]
    else
      [[1, 0], [1, -1], [1, 1]]
    end
  end

  def moves
    side_attacks + forward_steps
  end

  def to_s
    "♟".colorize(@color)
  end

  private
  def forward_dir
    return 1 if self.color == :black
    -1
  end

  def side_attacks
    other_color = self.color == :white ? :black : :white
    result = []
    left = [@pos[0] + forward_dir, @pos[1] - 1]
    right = [@pos[0] + forward_dir, @pos[1] + 1]
    if @board.valid_pos?(left) && @board[left].color == other_color
      result << left
    elsif @board.valid_pos?(right) && @board[right].color == other_color
      result << right
    end
    result

  end

  def forward_steps
    result = []
    new_pos = [@pos[0] + forward_dir, @pos[1]]
    result << new_pos if @board[new_pos].empty?
    new_pos = [@pos[0] + (forward_dir * 2), @pos[1]]
    if @board[new_pos].empty? && result.length == 1 && at_start_row?
      result << new_pos
    end
    result
  end

  def at_start_row?
    return true if self.pos[0] == 6 && self.color == :white
    return true if self.pos[0] == 1 && self.color == :black
    false
  end

end
