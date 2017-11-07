require_relative 'cursor'
require_relative 'board'
require 'colorize'

class Display
  attr_reader :board, :cursor

  def initialize(board)
    @cursor = Cursor.new([0,0], board)
    @board = board
  end


  def render(color, message=nil)
    puts "Welcome to CHESS!"
    puts "It's #{color}'s turn."
    (0..7).to_a.each { |x_coord| print "  #{x_coord}"} # to print the col positions
    print "\n"
    (0..7).to_a.each_with_index do |x, i|
      print "#{i}" # to print the row positions
      light_blue = i.even?

      (0..7).to_a.each do |y|
        background_color = light_blue ? :cyan : :white
        background_color = [x,y] == self.cursor.cursor_pos ? :yellow : background_color
        symbol = " #{@board[[x,y]].symbol} ".colorize(:background => background_color)
        print symbol
        light_blue = !light_blue
      end
      print "\n"
    end
    print "\n"
    puts message unless message.nil?
  end

end
