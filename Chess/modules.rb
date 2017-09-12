module SlidingPiece
  def moves
    moves_array = []
    curr_pos = self.pos.dup
    self.move_dirs.each do |dir|
      moves_array += trace_moves(curr_pos, dir)
    end
    moves_array = moves_array.reject { |move| move == self.pos }
  end

  def trace_moves(curr_pos, dir)
    return [] if !self.board.in_bounds(curr_pos)
    new_row = curr_pos[0] + dir[0]
    new_col = curr_pos[1] + dir[1]
    next_pos = [new_row, new_col]
    return [curr_pos] + trace_moves(next_pos, dir)
  end

  # def horizontal_moves(curr_pos)
  #   result = []
  #   curr_pos[1] = curr_pos[1] == 7 ? 0 : curr_pos[1] + 1
  #   until curr_pos[1] == self.pos[1]
  #     result.push(curr_pos)
  #     curr_pos = curr_pos.dup
  #     curr_pos[1] = curr_pos[1] < 7 ? curr_pos[1] + 1 : 0
  #   end
  #   result
  # end
  #
  # def vertical_moves(curr_pos)
  #   result = []
  #   curr_pos[0] = curr_pos[0] == 7 ? 0 : curr_pos[0] + 1
  #   until curr_pos[0] == self.pos[0]
  #     result.push(curr_pos)
  #     curr_pos = curr_pos.dup
  #     curr_pos[0] = curr_pos[0] < 7 ? curr_pos[0] + 1 : 0
  #   end
  #   result
  # end
  #
  # def diagonal_left_moves(curr_pos)
  #   result = []
  #   # debugger
  #   if curr_pos[0] > curr_pos[1]
  #     curr_pos = [curr_pos[0] - curr_pos[1], 0]
  #   elsif curr_pos[0] == curr_pos[1]
  #     curr_pos = [0, 0]
  #   else
  #     curr_pos = [0, curr_pos[1] - curr_pos[0]]
  #   end
  #   until curr_pos == self.pos || result.include?(curr_pos)
  #     # debugger
  #     result.push(curr_pos)
  #     curr_pos = curr_pos.dup
  #     curr_pos[0] += 1
  #     curr_pos[1] += 1
  #     unless self.board.in_bounds(curr_pos)
  #       if curr_pos[0] > curr_pos[1]
  #         curr_pos = [curr_pos[0] - curr_pos[1], 0]
  #       elsif curr_pos[0] == curr_pos[1]
  #         curr_pos = [0, 0]
  #       else
  #         curr_pos = [0, curr_pos[1] - curr_pos[0]]
  #       end
  #     end
  #   end
  #   result
  # end
  #
  # def diagonal_right_moves(curr_pos)
  #   result = []
  #   if curr_pos.any? { |coord| [0, 7].include?(coord) }
  #     curr_pos.rotate!
  #   else
  #     curr_pos[0] -= 1
  #     curr_pos[1] += 1
  #   end
  #   # debugger
  #   until result.include?(curr_pos)
  #     # debugger
  #     result.push(curr_pos)
  #     curr_pos = curr_pos.dup
  #     curr_pos[0] -= 1
  #     curr_pos[1] += 1
  #     # if curr_pos.any? { |coord| [0, 7].include?(coord) }
  #     #   curr_pos.rotate!
  #     # else
  #     #   curr_pos[0] -= 1
  #     #   curr_pos[1] += 1
  #     # end
  #     if curr_pos.any? { |coord| [0, 7].include?(coord) }
  #       curr_pos.rotate!
  #     end
  #   end
  #   result
  # end

end

module SteppingPiece
  def moves
  end
end
