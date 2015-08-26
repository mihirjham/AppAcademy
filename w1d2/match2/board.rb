require './card';

class Board
  attr_reader :cards

  def initialize(cards = Array.new(2) {Array.new(2)})
    @cards = cards
  end

  def create_deck
    deck = Card::DECK
    arr = []
    until arr.length == (cards.length*cards[0].length)
      value = deck.sample
      arr << Card.new(value)
      arr << Card.new(value)
    end
    arr
  end

  def populate
    deck = create_deck
    deck.shuffle!
    cards.each do |arr|
      arr.length.times do |idx|
        arr[idx] = deck.pop
      end
    end
  end

  def render
    cards.each do |row|
      print("[")
      row.each_with_index do |card, idx|
        print(card.to_s)
        if(idx != row.length-1)
          print(",")
        end
      end
      print("]\n")
    end
  end

  def won?
    cards.flatten.each {|card| return false if !card.status}
    true
  end

  def reveal(guessed_pos)
    if(cards[guessed_pos[0]][guessed_pos[1]].status)
      return cards[guessed_pos[0]][guessed_pos[1]].value;
    end

    cards[guessed_pos[0]][guessed_pos[1]].reveal;
    return cards[guessed_pos[0]][guessed_pos[1]].value;
  end

  def hide(pos)
    cards[pos[0]][pos[1]].hide
  end
end
