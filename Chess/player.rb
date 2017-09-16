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
      end_turn = false
      until end_turn
        if !@start_pos.nil?
          message = "Selected #{@display.board[@start_pos].class} on #{@start_pos}, "
          message += "please select end position with cursor."
        end
        @display.render(@color, message)
        input = @display.cursor.get_input
        end_turn = make_move(input)
        system("clear")
        # if !input.nil? && @start_pos.nil?
        #   if @display.board[input].color != @color
        #     raise ChessError.new("Not your piece! Try again.")
        #   end
        #   message = "Selected #{@display.board[input].class} on #{input}, please select end position with cursor."
        #   @start_pos = input
        # elsif !input.nil?
        #   @display.board.move_piece(@start_pos, input)
        #   @start_pos = nil
        #   swap_turn = true
        # end

      end
    rescue ChessError => e
      message = e.message
      @start_pos = nil
      # sleep 0.5
      # system("clear")
      retry
    end
  end

  def make_move(input)
    if !input.nil? && @start_pos.nil?
      system("clear")
      if @display.board[input].color != @color
        raise ChessError.new("Not your piece! Try again.")
      end
      @start_pos = input
      # message = "Selected #{@display.board[input].class} on #{input}, please select end position with cursor."
      # @display.render(@color, message)
      return false
    elsif !input.nil?
      @display.board.move_piece(@start_pos, input)
      @start_pos = nil
      return true
    end
    false
  end
end
