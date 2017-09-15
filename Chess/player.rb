require_relative 'display'
require_relative 'cursor'

class HumanPlayer
  attr_reader :color, :display

  def initialize(color, display)
    @color = color
    @display = display
    @start_pos = nil
    # @end_pos = nil
  end

  def play_turn
    message = nil
    begin
      swap_turn = false
      until swap_turn
        @display.render(@color, message)
        input = @display.cursor.get_input
        system("clear")
        if !input.nil? && @start_pos.nil?
          raise ChessError.new("Not your piece! Try again.") if @display.board[input].color != @color
          message = "Selected piece on #{input}, please select end position with cursor."
          @start_pos = input
        elsif !input.nil?
          @display.board.move_piece(@start_pos, input)
          @start_pos = nil
          swap_turn = true
        end
      end
    rescue ChessError => e
      message = e.message
      @start_pos = nil
      # sleep 0.5
      # system("clear")
      retry
    end
  end
end
