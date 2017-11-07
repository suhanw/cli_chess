require_relative 'board'
require_relative 'display'
require_relative 'player'

class Game
  attr_reader :b, :player1, :player2, :curr_player, :d

  def initialize(play_computer)
    @b = Board.new
    @d = Display.new(b)
    @player1 = play_computer ? ComputerPlayer.new('black', @d) : HumanPlayer.new('black', @d)
    @player2 = HumanPlayer.new('white', @d)
    @curr_player = player2
  end

  def play
    until self.b.checkmate?(self.curr_player.color)
      self.curr_player.play_turn(@b)
      swap_turn
    end

    message = "Checkmate! #{self.curr_player.color} loses!"
    system("clear")
    @d.render(self.curr_player.color, message)
  end

  private
  def swap_turn
    @curr_player = @curr_player == @player1 ? @player2 : @player1
  end
end

if __FILE__ == $PROGRAM_NAME
  play_again = true
  while play_again
    system("clear")
    puts 'Play against computer? (Y/N)'
    play_computer = gets.chomp.upcase == 'Y' ? true : false
    Game.new(play_computer).play
    puts 'Play again? (Y/N)'
    play_again = gets.chomp.upcase == 'Y' ? true : false
  end
  puts 'Thanks for playing!'
end
