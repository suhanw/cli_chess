require_relative 'piece'
require_relative 'exception'
require 'byebug'


class Board
  def initialize
    @board = Array.new(8) { Array.new(8) }
    @board[0] = [
      Rook.new("black", [0,0], self),
      Knight.new("black", [0,1],self),
      Bishop.new("black", [0,2],self),
      Queen.new("black", [0,3],self),
      King.new("black", [0,4],self),
      Bishop.new("black", [0,5],self),
      Knight.new("black", [0,6],self),
      Rook.new("black", [0,7],self)
    ]

    @board[1] = [
      Pawn.new("black", [1,0],self),
      Pawn.new("black", [1,1],self),
      Pawn.new("black", [1,2],self),
      Pawn.new("black", [1,3],self),
      Pawn.new("black", [1,4],self),
      Pawn.new("black", [1,5],self),
      Pawn.new("black", [1,6],self),
      Pawn.new("black", [1,7],self)
    ]

    @board[7] = [
      Rook.new("white", [7,0] ,self),
      Knight.new("white", [7,1] ,self),
      Bishop.new("white", [7,2] ,self),
      Queen.new("white", [7,3] ,self),
      King.new("white", [7,4] ,self),
      Bishop.new("white", [7,5] ,self),
      Knight.new("white", [7,6] ,self),
      Rook.new("white", [7,7] ,self)
    ]

    @board[6] = [
      Pawn.new("white", [6,0] ,self),
      Pawn.new("white", [6,1] ,self),
      Pawn.new("white", [6,2] ,self),
      Pawn.new("white", [6,3] ,self),
      Pawn.new("white", [6,4] ,self),
      Pawn.new("white", [6,5] ,self),
      Pawn.new("white", [6,6] ,self),
      Pawn.new("white", [6,7] ,self)
    ]

    null_piece = NullPiece.instance

    @board.each_with_index do |row, x|
      row.each_with_index do |col, y|
        self[[x, y]] = null_piece if self[[x, y]].nil?
      end
    end
  end

  def []=(pos, piece)
    x, y = pos
    @board[x][y] = piece
  end

  def [](pos)
    x, y = pos
    @board[x][y]
  end

  def move_piece!(start_pos, end_pos) # for use in Piece#move_into_check?
    self[end_pos], self[start_pos] = self[start_pos], NullPiece.instance
    self[end_pos].pos = end_pos
  end

  def move_piece(start_pos, end_pos)
    if self[start_pos].is_a?(NullPiece)
      raise ChessError.new("No piece to move! Try again.")
    elsif self[start_pos].move_into_check?(end_pos)
      raise ChessError.new("You are moving into check! What are you doing?")
    elsif !self[start_pos].valid_moves.include?(end_pos)
      raise ChessError.new("Not a valid move! Try again.")
    end

    self[end_pos], self[start_pos] = self[start_pos], NullPiece.instance
    self[end_pos].pos = end_pos
  end


  def in_bounds?(pos)
    pos.all? {|coordinate| coordinate.between?(0, 7) }
  end

  def in_check?(color)
    king_pos = []
    opponent_moves = []
    board.each do |row|
      row.each do |piece|
        # (1) finding the position of the King on the board
        if piece.class == King && piece.color == color
          king_pos = piece.pos
        # (2) collecting moves for all opponent pieces
        elsif piece.color != color
          opponent_moves += piece.moves
        end
      end
    end

    # return true if opponent moves include king position
    opponent_moves.include?(king_pos)
  end

  def checkmate?(color)
    in_check = self.in_check?(color)
    no_valid_moves = true
    @board.each do |row|
      row.each do |piece|
        if piece.color == color && !piece.valid_moves.empty?
          no_valid_moves = false
        end
      end
    end
    in_check && no_valid_moves
  end

  def dup
    board_dup = Board.new
    (0..7).to_a.each do |row_i|
      (0..7).to_a.each do |col_i|
        if self[[row_i, col_i]].is_a?(NullPiece)
          board_dup[[row_i, col_i]] = NullPiece.instance
        else
          piece = self[[row_i, col_i]]
          board_dup[[row_i, col_i]] = piece.class.new(piece.color, piece.pos.dup, board_dup)
        end
      end
    end
    return board_dup
  end

  def capture_move(color)
    all_piece_pos(color).each do |piece_pos|
      if self[piece_pos].capture_pos
        return [piece_pos, self[piece_pos].capture_pos]
      end
    end
    nil
  end

  def all_piece_with_valid_moves(color)
    all_piece_pos(color).select do |piece_pos|
      self[piece_pos].valid_moves.length > 0
    end
  end

  private
  def all_piece_pos(color)
    all_piece_pos = []
    board.each do |row|
      row.each do |piece|
        next if piece.color != color
        all_piece_pos.push(piece.pos)
      end
    end
    all_piece_pos
  end

  attr_reader :board
end
