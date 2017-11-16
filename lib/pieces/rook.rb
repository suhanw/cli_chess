require_relative "../piece"

class Rook < Piece
  include SlidingPiece

  def initialize(color, pos, board)
    super(color, pos, board)
    if color == "black"
      @symbol = "\u265c".colorize(:color => :black)
    else
      @symbol = "\u2656"
    end
    @move_dirs = [
      [0, 1],
      [0, -1],
      [1, 0],
      [-1, 0]
    ]
  end

end
