require './board'

class Game
  attr_reader :board
  def initialize(board)
    @board = board
  end

  def play
    until board.solved?
      board.render
      input = prompt
      board.update_position([input[0],input[1]], input[2])
    end
    puts "Solved!"
  end

  def prompt
    puts "Please choose a position, and number to write in that position - row,column,value (like 0,0,9)"
    a = gets.chomp.split(',').map {|el| el.to_i}
    a
  end
end

if(__FILE__ == $PROGRAM_NAME)
  file = "./puzzles/sudoku1.txt";
  board = Board::from_file(file);
  Game.new(board).play
end
