require './tile';

class Board
  UNIQUE = (1..9).to_a;

  attr_reader :grid;

  def initialize(grid)
    @grid = grid;
  end

  def self.from_file(file_path)
    ary = File.readlines(file_path).map {|line| line.chomp };
    ary.map! do |line|
      line = line.split("");
      line = line.map do |num|
        if(num == "0")
          num = Tile.new(false);
        else
          num = Tile.new(num.to_i, true);
        end
      end
    end
    return Board.new(ary);
  end

  def update_position(pos, value)
    if(grid[pos[0]][pos[1]].given)
      return;
    end
    grid[pos[0]][pos[1]].value = value;
  end

  def render
    @grid.each do |row|
      row.each do |tile|
        print(tile.to_s);
      end
      print("\n");
    end
  end

  def row_solved?
    grid.each do |row|
      arr = []
      row.each do |tile|
        arr << tile.value unless tile.value.nil?
      end
      return false unless arr.uniq.sort == UNIQUE
    end
    true
  end

  def col_solved?
    grid.transpose.each do |col|
      arr=[]
      col.each do |tile|
        arr << tile.value unless tile.value.nil?
      end
      return false unless arr.uniq.sort == UNIQUE
    end
    true
  end

  def three_solved?
    i = 0;
    while(i < 9)
      j = 0;
      while(j < 9)
        a = (0+i..2+i).to_a;
        b = (0+j..2+j).to_a;
        c = a.zip(b) + a.zip(b.rotate) + a.zip(b.rotate.rotate);
        return false unless ind_solved?(c)
        j += 3;
      end
      i += 3;
    end
    true
  end

  def ind_solved?(arr)
    flattened_square = []
    arr.each do |pos|
      flattened_square << grid[pos[0]][pos[1]].value unless grid[pos[0]][pos[1]].value.nil?
    end
    return false unless flattened_square.uniq.sort == UNIQUE
    true
  end

  def solved?
    return three_solved? && row_solved? && col_solved?
  end

end
