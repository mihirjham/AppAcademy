require_relative 'player'

class Dealer < Player
  attr_reader :bets

  def initialize
    super("dealer", 0)

    @bets = {}
  end

  def place_bet(dealer, amt)
    raise Exception.new "Dealer doesn't bet"
  end

  def play_hand(deck)
    until hand.points >= 17 || hand.busted?
      hand.hit(deck)
    end

  end

  def take_bet(player, amt)
    @bets[player] = amt
  end

  def pay_bets
    @bets.each do |player, bet|
      if player.hand.beats?(hand)
        player.pay_winnings(bet*2)
      end
    end
  end
end
