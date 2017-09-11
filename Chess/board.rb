require_relative 'piece'
require_relative 'exception'
require 'byebug'


class Board
  def initialize
    @board = Array.new(8) { Array.new(8) }
    @board[0] = [
      Rook.new("black"),
      Knight.new("black"),
      Bishop.new("black"),
      Queen.new("black"),
      King.new("black"),
      Bishop.new("black"),
      Knight.new("black"),
      Rook.new("black")
    ]

    @board[1] = [
      Pawn.new("black"),
      Pawn.new("black"),
      Pawn.new("black"),
      Pawn.new("black"),
      Pawn.new("black"),
      Pawn.new("black"),
      Pawn.new("black"),
      Pawn.new("black")
    ]

    @board[7] = [
      Rook.new("white"),
      Knight.new("white"),
      Bishop.new("white"),
      Queen.new("white"),
      King.new("white"),
      Bishop.new("white"),
      Knight.new("white"),
      Rook.new("white")
    ]

    @board[6] = [
      Pawn.new("white"),
      Pawn.new("white"),
      Pawn.new("white"),
      Pawn.new("white"),
      Pawn.new("white"),
      Pawn.new("white"),
      Pawn.new("white"),
      Pawn.new("white")
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

  def move_piece(start_pos, end_pos)
    raise ChessError.new("No piece to move!")if self[start_pos].nil?
    # debugger
    raise ChessError.new("Piece exists at end_pos")unless self[end_pos].nil?
  end

  def in_bounds(pos)
    pos.all? {|coordinate| coordinate.between?(0, 7) }
  end
end
