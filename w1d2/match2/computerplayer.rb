class ComputerPlayer
  attr_reader :name;

  def initialize(name, board)
    @name = name
    @known_cards = Hash.new(Array.new)
    @matched_pos = []
    @previous_guess = nil
    @current_guess = nil
    @row = board.cards.length
    @column = board.cards[0].length
    @flipped_cards = []
  end

  def get_guess
    if @known_cards.empty?
      @previous_guess = [rand(@row), rand(@column)]
      return @previous_guess
    end

    possible_positions = []
    @row.times do |row_idx|
       @column.times do |col_idx|
         possible_positions << [row_idx,col_idx];
       end
    end

    possible_positions -= @known_cards.values
    possible_positions -= @flipped_cards

    if @matched_pos.empty?
      @previous_guess = possible_positions.sample
      return @previous_guess
    end

    @previous_guess = @matched_pos[0]
    return @previous_guess

  end

  def update_flipped_cards(board)
    board.cards.each_with_index do |row, row_idx|
      row.each_with_index do |card, col_idx|
          if card.status
            @flipped_cards << [row_idx, col_idx]
          end
      end
    end
  end


  def received_revealed_card(value)
    @known_cards[value] << @previous_guess
    receive_match
  end

  def receive_match
    @known_cards.each do |card_value, arr|
      if arr.length >=2
        arr.each {|pos| @matched_pos << pos}
      end
    end

    @matched_pos -= @flipped_cards
  end

end
