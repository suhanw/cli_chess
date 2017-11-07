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
    @curr_player = player2
  end

  def play
    until self.b.checkmate?(@curr_player.color)
      @curr_player.play_turn
      swap_turn
    end

    message = "Checkmate! #{@curr_player.color} loses!"
    system("clear")
    @d.render(@curr_player.color, message)
  end

  def swap_turn
    @curr_player = @curr_player == @player1 ? @player2 : @player1
  end

end

if __FILE__ == $PROGRAM_NAME
  play_again = true
  while play_again
    Game.new.play
    puts 'Play again? (Y/N)'
    play_again = gets.chomp.upcase == 'Y' ? true : false
    system("clear")
  end
  puts 'Thanks for playing!'
end
