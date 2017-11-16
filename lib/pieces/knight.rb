require_relative "../piece"

class Knight < Piece
  include SteppingPiece

  def initialize(color, pos, board)
    super(color, pos, board)
    if color == "black"
      @symbol = "\u265e".colorize(:color => :black)
    else
      @symbol = "\u2658"
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
