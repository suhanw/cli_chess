require_relative "../piece"

class Pawn < Piece
  def initialize(color, pos, board)
    super(color, pos, board)
    if color == "black"
      @symbol = "\u265f".colorize(:color => :black)
    else
      @symbol = "\u2659"
    end

  end

  def moves
    moves_array = []

    moves_array += side_attacks
    forward_steps.each do |move|
      new_pos = [self.pos[0] + move[0], self.pos[1] + move[1]]
      if self.board.in_bounds?(new_pos) && self.board[new_pos].is_a?(NullPiece)
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
    if self.board.in_bounds?(left_diag)
      if self.board[left_diag].color != self.color && !self.board[left_diag].color.nil?
        moves_array.push(left_diag)
      end
    end
    if self.board.in_bounds?(right_diag)
      if self.board[right_diag].color != self.color && !self.board[right_diag].color.nil?
        moves_array.push(right_diag)
      end
    end

    moves_array
  end

  def forward_steps
    if self.at_start_row?
      # 1 step or 2 steps if at start row
      if self.color == 'black'
        [[1, 0], [2, 0]]
      else
        [[-1, 0], [-2, 0]]
      end

    else
      # just 1 step if not at start row
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
