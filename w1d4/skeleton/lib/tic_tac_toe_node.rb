require_relative 'tic_tac_toe'

class TicTacToeNode
  attr_reader :board, :next_mover_mark, :prev_move_pos

  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board = board
    @next_mover_mark = next_mover_mark
    @prev_move_pos = prev_move_pos
  end

  def losing_node?(evaluator)
    if @board.over? && @board.winner == next_mover_mark
      return true
    end

    if @board.over? && (@board.winner == nil || @board.winner == evaluator)
      return false
    end

    if(evaluator == next_mover_mark)
      children.all? {|child| child.losing_node?(evaluator)}
    else
      children.any? {|child| child.losing_node?(evaluator)}
    end

  end

  def winning_node?(evaluator)
    if @board.over? && @board.winner == evaluator
      return true
    end

    if @board.over? && (@board.winner == nil || @board.winner == next_mover_mark)
      return false
    end

    if evaluator == next_mover_mark
      children.any? {|child| child.winning_node?(evaluator)}
    else
      children.all? {|child| child.winning_node?(evaluator)}
    end
  end

  # This method generates an array of all moves that can be made after
  # the current move.
  def children
    positions = []

    (0..2).to_a.each do |row|
      (0..2).to_a.each do |col|
        if @board.empty?([row,col])
          dup_board = @board.dup
          dup_board.[]=([row,col], next_mover_mark)

          if @next_mover_mark == :x
            new_next_mover_mark = :o
          else
            new_next_mover_mark = :x
          end

          new_prev_move_pos = [row,col]
          positions << TicTacToeNode.new(dup_board, new_next_mover_mark, new_prev_move_pos)
        end
      end
    end

    positions
  end

end
