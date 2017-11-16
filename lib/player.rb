require_relative 'display'
require_relative 'cursor'

class HumanPlayer
  attr_reader :color, :display
  attr_accessor :start_pos

  def initialize(color, display)
    @color = color
    @display = display
    @start_pos = nil
  end

  def play_turn(board)
    message = ""
    begin
      end_turn = false
      until end_turn
        system("clear")
        self.display.render(@color, message + render_message(board), valid_moves(board))
        input = self.display.cursor.get_input
        end_turn = make_move(board, input)
        message = ""
      end
    rescue ChessError => e
      message = e.message
      self.start_pos = nil
      retry
    end
  end


  def make_move(board, input)
    if !input.nil? && self.start_pos.nil? # case when player is selecting a piece to move
      system("clear")
      if board[input].color != @color # check that player is not selecting opponent piece
        raise ChessError.new("Not your piece! Try again.")
      end
      self.start_pos = input
      return false # indicates that player turn is not over yet
    elsif !input.nil? # case when player has selected piece to move
      board.move_piece(self.start_pos, input) # will throw error if move is not valid
      self.start_pos = nil
      return true # indicates that player turn is over
    end
    false
  end

  private
  def render_message(board)
    message = ""
    if !self.start_pos.nil?
      message = "Selected #{board[self.start_pos].class} on #{self.start_pos}, "
      message += "please select end position with cursor."
    elsif board.in_check?(self.color)
      message = "Your king is in check. Please do something."
    end
    return message
  end

  def valid_moves(board)
    valid_moves = nil
    if !self.start_pos.nil?
      valid_moves = board[self.start_pos].valid_moves
    end
    valid_moves
  end
end

class ComputerPlayer
  attr_reader :color, :display

  def initialize(color, display)
    @color = color
    @display = display
  end

  def play_turn(board)
    system("clear")
    self.display.render(@color)
    sleep(2)
    # identify a piece that can move to capture
    capture_move = board.capture_move(self.color)
    if capture_move # if there is an opponent piece that can be captured, move to capture
      self.make_move(board, capture_move[0], capture_move[1])
    else # else, move randomly
      random_piece_pos = board.all_piece_with_valid_moves(self.color).sample
      random_move_pos = board[random_piece_pos].valid_moves.sample
      self.make_move(board, random_piece_pos, random_move_pos)
    end

  end

  def make_move(board, start_pos, end_pos)
    board.move_piece(start_pos, end_pos)
  end
end
