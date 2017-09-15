require "Singleton"
require_relative "modules"
require_relative "board"

class Piece
  attr_reader :symbol, :color, :move_dirs
  attr_accessor :board, :pos

  def initialize(color, pos, board)
    @color = color
    @pos = pos
    @board = board
  end

  def valid_moves
    # 1. filter out moves that will cause king to be in check
    # move_into_check?
    # will call move_into_check? so we CANNOT call move_piece
    all_moves = self.moves
    all_moves.reject { |move| self.move_into_check?(move) }
  end

  def move_into_check?(end_pos)
    board_dup = self.board.dup
    board_dup.move_piece!(self.pos, end_pos)
    board_dup.in_check?(self.color)
  end
end

class King < Piece
  include SteppingPiece

  def initialize(color, pos, board)
    super(color, pos, board)
    if color == "black"
      @symbol = "\u265a".colorize(:color => :black)
    else
      @symbol = "\u265a"
    end
    @move_dirs = [
      [0, 1],
      [0, -1],
      [1, 0],
      [-1, 0],
      [1, 1],
      [-1, -1],
      [1, -1],
      [-1, 1]
    ]
  end
end

class Knight < Piece
  include SteppingPiece

  def initialize(color, pos, board)
    super(color, pos, board)
    if color == "black"
      @symbol = "\u265e".colorize(:color => :black)
    else
      @symbol = "\u265e"
    end
    @move_dirs = [
      [-2, -1],
      [-2,  1],
      [-1, -2],
      [-1,  2],
      [ 1, -2],
      [ 1,  2],
      [ 2, -1],
      [ 2,  1]
    ]
  end
end

class Pawn < Piece
  def initialize(color, pos, board)
    super(color, pos, board)
    if color == "black"
      @symbol = "\u265f".colorize(:color => :black)
    else
      # @symbol = "\u2659"
      @symbol = "\u265f"
    end

  end

  def moves
    moves_array = []

    moves_array += side_attacks
    forward_steps.each do |move|
      new_pos = [self.pos[0] + move[0], self.pos[1] + move[1]]
      if self.board.in_bounds(new_pos) && self.board[new_pos].is_a?(NullPiece)
        moves_array.push(new_pos)
      end
    end

    moves_array
  end

  def side_attacks
    if self.color == 'white'
      left_diag = [self.pos[0] - 1, self.pos[1] - 1]
      right_diag = [self.pos[0] - 1, self.pos[1] + 1]
    else
      left_diag = [self.pos[0] + 1, self.pos[1] - 1]
      right_diag = [self.pos[0] + 1, self.pos[1] + 1]
    end

    moves_array = []
    if self.board.in_bounds(left_diag)
      if self.board[left_diag].color != self.color && !self.board[left_diag].color.nil?
        moves_array.push(left_diag)
      end
    end
    if self.board.in_bounds(right_diag)
      if self.board[right_diag].color != self.color && !self.board[right_diag].color.nil?
        moves_array.push(right_diag)
      end
    end

    moves_array
  end

  def forward_steps
    if self.at_start_row?
      # 1 step or 2 steps
      if self.color == 'black'
        [[1, 0], [2, 0]]
      else
        [[-1, 0], [-2, 0]]
      end

    else
      # just 1 step
      if self.color == 'black'
        [[1, 0]]
      else
        [[-1, 0]]
      end
    end
  end

  def at_start_row?
    if self.color == 'black'
      self.pos[0] == 1
    else
      self.pos[0] == 6
    end
  end
end

class Bishop < Piece
  include SlidingPiece

  def initialize(color, pos, board)
    super(color, pos, board)
    if color == "black"
      @symbol = "\u265d".colorize(:color => :black)
    else
      @symbol = "\u265d"
    end
    @move_dirs = [
      [1, 1],
      [-1, -1],
      [1, -1],
      [-1, 1]
    ]
  end

end

class Rook < Piece
  include SlidingPiece

  def initialize(color, pos, board)
    super(color, pos, board)
    if color == "black"
      @symbol = "\u265c".colorize(:color => :black)
    else
      @symbol = "\u265c"
    end
    @move_dirs = [
      [0, 1],
      [0, -1],
      [1, 0],
      [-1, 0]
    ]
  end

end

class Queen < Piece
  include SlidingPiece

  def initialize(color, pos, board)
    super(color, pos, board)
    if color == "black"
      @symbol = "\u265b".colorize(:color => :black)
    else
      @symbol = "\u265b"
    end
    @move_dirs = [
      [0, 1],
      [0, -1],
      [1, 0],
      [-1, 0],
      [1, 1],
      [-1, -1],
      [1, -1],
      [-1, 1]
    ]
  end

end

class NullPiece < Piece
  include Singleton
  def initialize
    @symbol = " "
  end

  def moves
    # DUCK TYPING
    []
  end
end
