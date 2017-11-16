require_relative "piece"

class King < Piece
  include SteppingPiece

  def initialize(color, pos, board)
    super(color, pos, board)
    if color == "black"
      @symbol = "\u265a".colorize(:color => :black)
    else
      @symbol = "\u2654"
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
