require "colorize"
require_relative "cursor"
require_relative "board"
require_relative "pieces/piece"

class Display
  attr_reader :board, :cursor

  def initialize(board)
    @cursor = Cursor.new([0,0], board)
    @board = board
  end

  def render
    puts "\n"
    @board.rows.each_with_index do |row, i|
      row.each_with_index do |square, j|
        string = square.to_s
        if [i, j] == @cursor.cursor_pos
          if @cursor.selected
            string = " #{string} ".on_green
          else
            string = " #{string} ".on_red
          end
        else
          if (i+j) % 2 == 0
            string = " #{string} ".on_light_black
          else
            string = " #{string} ".on_light_blue
          end
        end
        print string
      end
      puts "\n"
    end

    puts "\n"
  end

end

if __FILE__ == $PROGRAM_NAME

  b = Board.new
  d = Display.new(b)

  while true
    d.render
    d.cursor.get_input
  end

end
