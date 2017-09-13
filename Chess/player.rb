require_relative 'display'
require_relative 'cursor'

class HumanPlayer
  attr_reader :color, :display

  def initialize(color, display)
    @color = color
    @display = display
  end

  def make_move
    @display.render_cursor_move
  end
end
