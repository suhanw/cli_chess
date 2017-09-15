require_relative 'board'
require_relative 'display'
require_relative 'player'

class Game
  attr_reader :b, :player1, :player2, :curr_player, :d

  def initialize
    @b = Board.new
    @d = Display.new(b)
    @player1 = HumanPlayer.new('black', @d)
    @player2 = HumanPlayer.new('white', @d)
    @curr_player = player1
  end

  def play
    until self.b.checkmate?(@curr_player.color)
      begin
        # notify_players
        # @d.render
        @curr_player.play_turn
        system("clear")
      rescue ChessError => e
        puts e.message
        sleep 0.5
        system("clear")
        retry
      end
      swap_turn
    end
  end

  def swap_turn
    @curr_player = @curr_player == @player1 ? @player2 : @player1
  end

  def notify_players
    puts "It's #{@curr_player.color}'s turn."
  end

end

if __FILE__ == $PROGRAM_NAME

  g = Game.new
  g.play
end
