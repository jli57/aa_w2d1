require_relative 'pieces/piece'

class MovementError < StandardError; end

class Board
  attr_reader :rows
  def initialize
    @rows = Array.new(8) { Array.new(8, NullPiece.instance) }
    @rows.each_with_index  do |row, i|
      # next if [2, 3, 4, 5].include?(i)
      case i
      when 0
        build_complex(:black, i)
      when 1
        build_pawns(:black, i)
      when 6
        build_pawns(:white, i)
      when 7
        build_complex(:white, i)
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

  private

  def build_pawns(color, row_idx)
    @rows[row_idx].each {|piece| piece = Pawn.new(color)}
  end

  def build_complex(color, row_idx)
  end


end
