# CLI Chess

This is a chess game programmed in Ruby for play on the terminal, and features the 'colorize' gem for rendering. It is built following OOP design principles. There are options for either a 2-player game, or a 1-player game against the computer. To guide a player, the valid moves are highlighted on the board.

## Instructions
Download and unzip the repo to your local machine. Open the terminal and run the following command to install the 'colorize' gem:
```
bundle install
```
Run this command to start playing:
```
ruby lib/game.rb
```
## Features and Implementation


### Object Oriented Programming

Using the OOP design principles, I defined a parent class to describe the common attributes for all pieces, and separate classes/modules for the different chess pieces based on how each of them behaves (i.e., how a piece is moved in a game). I took advantage of class inheritance to group similar chess pieces, which provides them with similar behaviors, while keeping the code DRY.

- `Piece`
  - `SteppingPiece`
    - `King`
    - `Knight`
  - `SlidingPiece`
    - `Queen`
    - `Bishop`
    - `Rook`
  - `Pawn`

Furthermore, to keep a separation of concerns, I defined separate classes that represents the `Player`, the `Board`, the `Display`, and the `Game`. In summary, the `Display` object renders the board (and any instructions/messages) based on the current game state, the `Board` validates and updates the game state based on how all the pieces are positioned, the `Player` provides input to move specific pieces into new positions, and lastly the `Game` initializes the board and players, and stops the game when a checkmate is reached.

Lastly, I used 'duck typing' in defining the `HumanPlayer` and `ComputerPlayer`, so that the `Game` object does not have to distinguish between the player types, and assumes the same behaviors for either types.

### Calculating Moves for a Sliding Piece

![Sliding Piece](docs/sliding_piece.gif)

Calculating the valid moves for a sliding piece lends itself to a recursive algorithm, where we can assume all the squares along an axis in a given direction are valid moves until we hit these base cases:
1. square is no longer in bounds
2. square is occupied by a piece of the same color
3. square is occupied by a piece of the opposing color, which also means the current square is a valid move

```ruby
def trace_moves(curr_pos, dir)
  return [] if !self.board.in_bounds?(curr_pos) # base case 1
  return [] if self.board[curr_pos].color == self.color # base case 2
  return [curr_pos] if self.board[curr_pos].color != self.color &&
                      !self.board[curr_pos].is_a?(NullPiece) #base case 3
  new_row = curr_pos[0] + dir[0]
  new_col = curr_pos[1] + dir[1]
  next_pos = [new_row, new_col]
  return [curr_pos] + trace_moves(next_pos, dir)
end
```

### Computer Player

![Computer Player](docs/comp_player.gif)

I used a simple strategy to define how the `ComputerPlayer` behaves in a game:
1. If there is an opponent piece that can be captured, move to capture that piece.
2. Otherwise, randomly select a piece and perform a randomized move.

```ruby
def play_turn(board)
  capture_move = board.capture_move(self.color)
  if capture_move # scenario 1
    self.make_move(board, capture_move[0], capture_move[1])
  else # scenario 2
    random_piece_pos = board.all_piece_with_valid_moves(self.color).sample
    random_move_pos = board[random_piece_pos].valid_moves.sample
    self.make_move(board, random_piece_pos, random_move_pos)
  end
end
```

### Logic of Checkmate

The `Board` detects a checkmate by using its own `Board#in_check?` method in conjunction with the `Piece#valid_moves` method. A game is in checkmate if both of these conditions are true:

1. The current color is in check
2. All other pieces of the same color have no more valid moves

```ruby
def checkmate?(color)
  in_check = self.in_check?(color) # condition 1
  no_valid_moves = self.all_piece_with_valid_moves(color).length == 0 # condition 2
  in_check && no_valid_moves
end
```
