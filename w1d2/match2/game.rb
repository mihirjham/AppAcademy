require './board'
require './humanplayer'
require './computerplayer'

class Game
  attr_reader :board, :previous_guess, :player
  def initialize(board, player)
    @board = board
    @player = player;
    @previous_guess = nil
  end


  def make_guess(pos)
    player.received_revealed_card(board.reveal(pos))
    if previous_guess.nil?
      @previous_guess = pos
      return
    end
    if board.reveal(@previous_guess) == board.reveal(pos)
      @previous_guess = nil
    else
      board.render

      sleep(1)
      board.hide(@previous_guess)
      board.hide(pos)
      @previous_guess = nil
    end
  end


  def play
    p board.cards
    until board.won?
      system('clear')
      board.render
      player.update_flipped_cards(board)
      pos = player.get_guess
      make_guess(pos)
    end
    puts "Game Over"
  end
end


if(__FILE__ == $PROGRAM_NAME)
  board = Board.new(Array.new(2) {Array.new(2)});
  board.populate;
  #player = HumanPlayer.new("Peyton");
  player = ComputerPlayer.new("Eli", board);
  game = Game.new(board, player);
  game.play;
end
