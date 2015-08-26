require 'colorize'

class Tile
  attr_accessor :value;
  attr_reader  :given;

  def initialize(value=nil, given)
    @value = value
    @given = given
  end

  def to_s
    if(given)
      return value.to_s.colorize(:blue);
    end

    if(value.nil?)
      return "_";
    end

    return value;
  end
  
end
