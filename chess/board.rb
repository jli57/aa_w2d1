require_relative 'pieces/piece'

class MovementError < StandardError; end

class Board
  attr_reader :rows
  def initialize
    @rows = Array.new(8) { Array.new(8, nil) }
    @rows.each_with_index  do |row, i|
      next unless [0, 1, 6, 7].include?(i)
      row.each_index do |j|
        @rows[i][j] = NullPiece.new
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

  def move_piece(start_pos, _end_pos)
    raise MovementError unless self[start_pos]
    
  end
end
