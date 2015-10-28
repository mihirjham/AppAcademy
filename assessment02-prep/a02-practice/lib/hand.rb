class Hand
  # This is called a *factory method*; it's a *class method* that
  # takes the a `Deck` and creates and returns a `Hand`
  # object. This is in contrast to the `#initialize` method that
  # expects an `Array` of cards to hold.
  def self.deal_from(deck)
    Hand.new(deck.take(2))
  end

  attr_accessor :cards

  def initialize(cards)
    @cards = cards
  end

  def points
    sum = 0
    aces = 0
    @cards.each do |card|
      if card.value == :ace
        aces += 1
        next
      end
      sum += card.blackjack_value
    end

    sum += aces*11
    while sum > 21 && aces > 0
      sum -= 10
    end
    sum
  end

  def busted?
    points > 21
  end

  def hit(deck)
    if busted?
      raise Exception.new "already busted"
    end

    @cards += deck.take(1)
  end

  def beats?(other_hand)
    return true if points > other_hand.points && !busted?
    return true if !busted? && other_hand.busted?
    return false if other_hand.points > points && !other_hand.busted?
    return false if !other_hand.busted? && busted?
    return false if other_hand.points == points && !busted? && !other_hand.busted?
  end

  def return_cards(deck)
    deck.return(@cards)
    @cards = []
  end

  def to_s
    @cards.join(",") + " (#{points})"
  end
end
