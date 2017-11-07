require_relative 'cursor'
require_relative 'board'
require 'colorize'

class Display
  attr_reader :board, :cursor

  def initialize(board)
    @cursor = Cursor.new([0,0], board)
    @board = board
  end


  def render(color, message=nil, valid_moves=nil)
    puts "Welcome to CHESS!"
    puts "It's #{color}'s turn."
    (0..7).to_a.each { |x_coord| print "  #{x_coord}"} # to print the col positions
    print "\n"
    (0..7).to_a.each_with_index do |x, i|
      print "#{i}" # to print the row positions
      cyan = i.even?

      (0..7).to_a.each do |y|
        background_color = cyan ? :cyan : :white
        if valid_moves # highlight valid moves for selected piece
          background_color = valid_moves.include?([x,y]) ? :light_blue : background_color
        end
        background_color = [x,y] == self.cursor.cursor_pos ? :yellow : background_color
        symbol = " #{@board[[x,y]].symbol} ".colorize(:background => background_color)
        print symbol
        cyan = !cyan
      end
      print "\n"
    end
    print "\n"
    puts message unless message.nil?
  end

end
