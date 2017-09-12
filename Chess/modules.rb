module SlidingPiece
  def moves
    moves_array = []
    curr_pos = self.pos.dup
    self.move_dirs.each do |dir|
      new_row = curr_pos[0] + dir[0]
      new_col = curr_pos[1] + dir[1]
      next_pos = [new_row, new_col]
      moves_array += trace_moves(next_pos, dir)
    end
    moves_array = moves_array.reject { |move| move == self.pos }
  end

  def trace_moves(curr_pos, dir)
    return [] if !self.board.in_bounds(curr_pos)
    return [] if self.board[curr_pos].color == self.color
    return [curr_pos] if self.board[curr_pos].color != self.color && !self.board[curr_pos].is_a?(NullPiece)
    new_row = curr_pos[0] + dir[0]
    new_col = curr_pos[1] + dir[1]
    next_pos = [new_row, new_col]
    return [curr_pos] + trace_moves(next_pos, dir)
  end
end

module SteppingPiece
  def moves
    moves_array = []
    curr_pos = self.pos.dup
    self.move_dirs.each do |dir|
      next_pos = [curr_pos[0] + dir[0], curr_pos[1] + dir[1]]
      if self.board.in_bounds(next_pos) && self.board[next_pos].color != self.color
        moves_array.push(next_pos)
      end
    end
    moves_array
  end
end
