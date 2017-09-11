require "Singleton"

class Piece
  attr_reader :symbol, :color, :move_dirs, :position
  def initialize(color)
    @color = color
  end
end

class King < Piece

  def initialize(color)
    super(color)
    if color == "black"
      @symbol = "\u265a"
    else
      @symbol = "\u2654"
    end
  end
end

class Knight < Piece
  def initialize(color)
    super(color)
    if color == "black"
      @symbol = "\u265e"
    else
      @symbol = "\u2658"
    end
  end
end

class Pawn < Piece
  def initialize(color)
    super(color)
    if color == "black"
      @symbol = "\u265f"
    else
      @symbol = "\u2659"
    end
  end
end

class Bishop < Piece
  def initialize(color)
    super(color)
    if color == "black"
      @symbol = "\u265d"
    else
      @symbol = "\u2657"
    end
    @move_dirs = ["D"]
  end

end

class Rook < Piece
  def initialize(color)
    super(color)
    if color == "black"
      @symbol = "\u265c"
    else
      @symbol = "\u2656"
    end
    @move_dirs = ["H", "V"]
  end

end

class Queen < Piece
  def initialize(color)
    super(color)
    if color == "black"
      @symbol = "\u265b"
    else
      @symbol = "\u2655"
    end
    @move_dirs = ["H", "V", "D"]
  end

end

class NullPiece < Piece
  include Singleton

  def initialize
    @symbol = " "
  end
end
