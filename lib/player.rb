require_relative 'display'
require_relative 'cursor'

class HumanPlayer
  attr_reader :color, :display

  def initialize(color, display)
    @color = color
    @display = display
    @start_pos = nil
  end

  def play_turn
    message = ""
    begin
      end_turn = false
      until end_turn
        system("clear")
        @display.render(@color, message + render_message, valid_moves)
        input = @display.cursor.get_input
        end_turn = make_move(input)
        message = ""
      end
    rescue ChessError => e
      message = e.message
      @start_pos = nil
      retry
    end
  end

  def render_message
    message = ""
    if !@start_pos.nil?
      message = "Selected #{@display.board[@start_pos].class} on #{@start_pos}, "
      message += "please select end position with cursor."
    elsif self.display.board.in_check?(self.color)
      message = "Your king is in check. Please do something."
    end
    return message
  end

  def valid_moves
    valid_moves = nil
    if !@start_pos.nil?
      valid_moves = self.display.board[@start_pos].valid_moves
    end
    valid_moves
  end

  def make_move(input)
    if !input.nil? && @start_pos.nil? # case when player is selecting piece to move
      system("clear")
      if @display.board[input].color != @color # check that player is not selecting opponent piece
        raise ChessError.new("Not your piece! Try again.")
      end
      @start_pos = input
      return false # indicates that player turn is not over yet
    elsif !input.nil? # case when player has selected piece to move
      @display.board.move_piece(@start_pos, input) # will throw error if move is not valid
      @start_pos = nil
      return true # indicates that player turn is over
    end
    false
  end
end

class ComputerPlayer
  attr_reader :color, :display

  def initialize(color, display)
    @color = color
    @display = display
  end

  def play_turn
    # identify a piece that can move to capture
    capture_move = self.display.board.capture_move(self.color)
    if capture_move # if there is an opponent piece that can be captured, move to capture
      self.make_move(capture_move[0], capture_move[1])
    else # else, move randomly
      random_piece_pos = self.display.board.all_piece_with_valid_moves(self.color).sample
      random_move_pos = self.display.board[random_piece_pos].valid_moves.sample
      self.make_move(random_piece_pos, random_move_pos)
    end

  end

  def make_move(start_pos, end_pos)
    self.display.board.move_piece(start_pos, end_pos)
  end
end
