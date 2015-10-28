
class Array
  def my_each(&blk)
    ary = [];
    self.length.times {|index| ary.push(blk.call(self[index]))};
  end

  def my_select(&blk)
    ary = []
    self.length.times { |index| ary << self[index] if blk.call(self[index])}
    ary
  end

  def my_reject(&blk)
    ary = self.my_select(&blk);
    #ary = [];
    #self.length.times { |index| ary << self[index] if !blk.call(self[index])}
    self - ary;
  end

  def my_any?(&blk)
    self.length.times { |index| return true if blk.call(self[index])}
    false
  end

  def my_all?(&blk)
    self.length.times { |index| return false if !blk.call(self[index])}
    true
  end

  def my_flatten
    ary = [];
    self.my_each do |l|
      if(l.class == Array)
        ary += l.my_flatten
      else
        ary.push(l);
      end
    end
    return ary;
  end

  def my_zip(*args)
    ary = []
    self.each_with_index do |current_el, idx|
      temp = []
      temp << current_el
      args.each do |argument_el|
        temp << argument_el[idx]
      end
      ary << temp
    end
    ary
  end

  def my_rotate(rotation=1)
    ary = self.dup;
    if(rotation < 0)
      rotation.abs.times do
        ary.unshift(ary.pop);
      end
      return ary;
    end

    rotation.times do
      ary.push(ary.shift);
    end
    ary;
  end

  def my_join(separator = "")
    str = ""
    self.each_with_index do |el, idx|
      str << el
      str << separator unless idx == (self.length - 1)
    end
    str
  end

  def my_reverse
    #Method push/pop
    ary = self.dup;
    ary2 = []
    self.length.times do
      ary2.push(ary.pop);
    end
    return ary2;

    #Method iterative
    # ary = [];
    # self.length.times do |index|
    #   ary.push(self[(-1*index)-1]);
    # end
    # ary;
  end

end
