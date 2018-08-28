require_relative 'pieces/piece'

class MovementError < StandardError; end

class Board
  attr_reader :rows
  def initialize
    @rows = Array.new(8) { Array.new(8, NullPiece.new) }
    @rows.each_with_index  do |row, i|
      next unless [0, 1, 6, 7].include?(i)
      row.each_index do |j|
        @rows[i][j] = Piece.new
      end
    end
  end

  def [](pos)
    x, y = pos
    @rows[x][y]
  end

  def []=(pos, val)
    x, y = pos
    @rows[x][y] = val
  end

  def move_piece(start_pos, end_pos)
    unless valid_pos?(start_pos)
      raise MovementError.new "Not a valid start position"; end
    unless valid_pos?(end_pos)
      raise MovementError.new "Not a valid end position"; end
    unless self[start_pos].is_a?(NullPiece)
      raise MovementError.new "No piece to move at start position"; end
    self[end_pos], self[start_pos] = self[start_pos], self[end_pos]
  end

  def valid_pos?(pos)
    pos.each {|idx| return false unless (0..7).include?(idx)}
    true
  end
end
