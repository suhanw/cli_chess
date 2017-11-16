require_relative "../piece"

class Queen < Piece
  include SlidingPiece

  def initialize(color, pos, board)
    super(color, pos, board)
    if color == "black"
      @symbol = "\u265b".colorize(:color => :black)
    else
      @symbol = "\u2655"
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
