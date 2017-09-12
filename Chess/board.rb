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

  def move_piece(start_pos, end_pos)
    raise ChessError.new("No piece to move!")if self[start_pos].nil?
    # debugger
    raise ChessError.new("Piece exists at end_pos")unless self[end_pos].nil?
  end

  def in_bounds(pos)
    pos.all? {|coordinate| coordinate.between?(0, 7) }
  end
end
