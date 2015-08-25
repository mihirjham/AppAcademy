require './player'
require './aiplayer'

class Game

  attr_reader :current_player, :players

  def initialize(players)
    @current_player = players[0]
    @starting_player = players[0]
    @players = players
    @fragment = ""
    @dictionary = File.readlines('./ghost-dictionary.txt').map {|el| el.chomp};
  end

  def play_game
    until(@players.length == 1)
      if(@current_player == @starting_player)
        next_player!
        @starting_player = @current_player;
      end
      @fragment = "";
      @players.each do |player|
        if(player.class == AIPlayer)
          player.current_fragment = "";
        end
      end

      play_round;
      eliminate_player if @players.any? {|player| player.status == "GHOST"}
      display_status;
    end

    puts("#{@players[0].name} wins!");
  end

  def eliminate_player
    eliminated_player_idx = @players.index { |player| player.status == "GHOST"}
    puts "#{@players[eliminated_player_idx].name} is eliminated"
    @players.delete_if { |player| player.status == "GHOST" }
  end

  def play_round
    take_turn(@current_player)
    if round_over?
      puts "#{@current_player.name} loses this round"
      @current_player.add_strike;
      return;
    else
      next_player!
    end
    play_round
  end

  def display_status
    puts("_" * 10);
    @players.each do |player|
      puts "#{player.name}'s status: #{player.status}"
    end
    puts("_" * 10)
  end

  def next_player!
    @players.push(@players.shift)
    @current_player = @players[0]
  end

  def take_turn(player)
    puts "Current fragment: #{@fragment}";
    puts "#{@current_player.name}: Enter a letter to guess"
    if(player.class == AIPlayer)
      player.current_fragment = @fragment;
      letter = player.get_guess;
    else
      letter = $stdin.gets.chomp
    end

    if valid_play?(@fragment + letter)
      @fragment += letter
    else
      puts "#{@fragment} + #{letter} is invalid, input another letter"
      take_turn(player)
    end
  end

  def round_over?
    @dictionary.include?(@fragment)
  end

  def valid_play?(string)
    @dictionary.each do |dictionary_word|
      return true if dictionary_word[0..(string.length - 1)] == string
    end
    false
  end
end

if(__FILE__ == $PROGRAM_NAME)
  a = Player.new("Eli")
  b = Player.new("Peyton")
  c = Player.new("Tom")
  d = Player.new("Ben")
  e = AIPlayer.new("Colin");
  players = [e,a]
  game = Game.new(players)
  game.play_game;
end
