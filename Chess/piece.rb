require "Singleton"
require_relative "modules"
require_relative "board"

class Piece
  attr_reader :symbol, :color, :move_dirs, :pos, :board
  def initialize(color, pos, board)
    @color = color
    @pos = pos
    @board = board
  end
end

class King < Piece

  def initialize(color, pos, board)
    super(color, pos, board)
    if color == "black"
      @symbol = "\u265a"
    else
      @symbol = "\u2654"
    end
  end
end

class Knight < Piece
  def initialize(color, pos, board)
    super(color, pos, board)
    if color == "black"
      @symbol = "\u265e"
    else
      @symbol = "\u2658"
    end
  end
end

class Pawn < Piece
  def initialize(color, pos, board)
    super(color, pos, board)
    if color == "black"
      @symbol = "\u265f"
    else
      @symbol = "\u2659"
    end
  end
end

class Bishop < Piece
  include SlidingPiece

  def initialize(color, pos, board)
    super(color, pos, board)
    if color == "black"
      @symbol = "\u265d"
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

class Rook < Piece
  include SlidingPiece

  def initialize(color, pos, board)
    super(color, pos, board)
    if color == "black"
      @symbol = "\u265c"
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

class Queen < Piece
  include SlidingPiece

  def initialize(color, pos, board)
    super(color, pos, board)
    if color == "black"
      @symbol = "\u265b"
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

class NullPiece < Piece
  include Singleton
  def initialize
    @symbol = " "
  end
end
