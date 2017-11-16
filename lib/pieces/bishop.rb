require_relative "../piece"

class Bishop < Piece
  include SlidingPiece

  def initialize(color, pos, board)
    super(color, pos, board)
    if color == "black"
      @symbol = "\u265d".colorize(:color => :black)
    else
      @symbol = "\u2657"
    end
    @move_dirs = [
      [1, 1],
      [-1, -1],
      [1, -1],
      [-1, 1]
    ]
  end

end
