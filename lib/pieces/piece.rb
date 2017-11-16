require "Singleton"
require_relative "modules"
require_relative "../board"

class Piece
  attr_reader :symbol, :color, :move_dirs
  attr_accessor :board, :pos

  def initialize(color, pos, board)
    @color = color
    @pos = pos
    @board = board
  end

  def valid_moves
    all_moves = self.moves
    # filter out moves that will cause king to be in check
    all_moves.reject { |move| self.move_into_check?(move) }
  end

  def move_into_check?(end_pos)
    board_dup = self.board.dup
    board_dup.move_piece!(self.pos, end_pos)
    board_dup.in_check?(self.color)
  end

  def capture_pos
    valid_moves.each do |move|
      if self.board[move].color != self.color && !self.board[move].is_a?(NullPiece)
        return move
      end
    end
    nil
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
