class Card
  DECK = (2..10).to_a + ['A', 'K','Q', 'J']
  attr_reader :status, :value;

  def initialize(value)
    @value = value;
    @status = false;
  end

  def reveal
    @status = true;
  end

  def hide
    @status = false;
  end

  def ==(card)
    return self.value == card.value;
  end

  def to_s
    return value if @status;
  end
end
