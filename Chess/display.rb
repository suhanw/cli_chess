require_relative 'cursor'
require_relative 'board'
require 'colorize'

class Display
  attr_reader :board, :cursor

  def initialize(board)
    @cursor = Cursor.new([0,0], board)
    @board = board
  end


  def render
    (0..7).to_a.each_with_index do |x, i|
      print "#{i}"
      light_blue = i.even?

      (0..7).to_a.each do |y|
        background_color = light_blue ? :light_blue : :white
        background_color = [x,y] == self.cursor.cursor_pos ? :yellow : background_color
        symbol = " #{@board[[x,y]].symbol} ".colorize(:color => :black, :background => background_color)
        print symbol
        light_blue = !light_blue
      end
      print "\n"
    end
    (0..7).to_a.each { |x_coord| print "  #{x_coord}"}
    print "\n"
  end

  def render_cursor_move
    begin
      while true
        self.render
        self.cursor.get_input
        system("clear")
      end
    rescue ChessError => e
      puts e.message
      sleep 0.5
      system("clear")
      retry
    end
  end
end

if __FILE__ == $PROGRAM_NAME
  d = Display.new(Board.new)
  d.render_cursor_move
end
