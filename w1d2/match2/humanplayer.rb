class HumanPlayer
  attr_reader :name;

  def initialize(name)
    @name = name;
  end

  def get_guess
    puts "Please choose a card (by position)"
    @guessed_pos = gets.chomp.split(',').map {|el| el.to_i}
  end

  def received_revealed_card(arg)
  end

  def update_flipped_cards(arg)
  end

end
