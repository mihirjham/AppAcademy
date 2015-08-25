class Player

  attr_reader :name, :strikes

  def initialize(name)
    @name = name
    @strikes = 0;
  end

  def add_strike
    @strikes += 1;
  end

  def status
    return "GHOST"[0...@strikes];
  end
end
