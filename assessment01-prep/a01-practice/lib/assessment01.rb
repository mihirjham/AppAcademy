class Array
  def my_inject(accumulator = nil, &block)
    if(accumulator.nil?)
      accumulator = self.shift
    end

    self.each do |el|
      accumulator = block.call(accumulator, el)
    end
    accumulator
  end
end

def is_prime?(num)
  i = 2;
  while(i < num)
    if(num % i == 0)
      return false;
    end
    i += 1;
  end
  return true;
end

def primes(count)
  i = 2;
  ary = []
  while(ary.length < count)
    if(is_prime?(i))
      ary << i;
    end
    i += 1;
  end
  return ary;
end

# the "calls itself recursively" spec may say that there is no method
# named "and_call_original" if you are using an older version of
# rspec. You may ignore this failure.
# Also, be aware that the first factorial number is 0!, which is defined
# to equal 1. So the 2nd factorial is 1!, the 3rd factorial is 2!, etc.
def factorials_rec(num)
  if(num == 1)
      return [1]
  end

  facts = factorials_rec(num-1)

  facts << facts.last * (num-1)
end

class Array
  def dups
    hash = Hash.new(Array.new)
    self.each_with_index do |el, i|
      hash[el] += [i];
    end
    hash.select {|k,v| v.length > 1}
  end
end

class String
  def symmetric_substrings
    i = 0;
    subs = []
    while(i < self.length)
      j = i + 1
      while(j < self.length)
        if(self[i..j].palindrome?)
          subs << self[i..j]
        end
        j += 1;
      end
      i += 1;
    end
    return subs;
  end

  def palindrome?
    self == self.reverse
  end
end

class Array
  def merge_sort(&prc)
    if(self.length < 2)
      return self
    end

    left = self[0...self.length/2].merge_sort(&prc)
    right = self[self.length/2...self.length].merge_sort(&prc)

    Array.merge(left,right,&prc)

  end

  private
  def self.merge(left, right, &prc)
    if(prc.nil?)
      prc = Proc.new{|left,right| left <=> right}
    end
    merged = []

    until left.empty? || right.empty?
      if(prc.call(left.first, right.first) == -1)
        merged << left.shift
      elsif(prc.call(left.first, right.first) == 1)
        merged << right.shift
      else
        merged << left.shift
        merged << right.shift
      end
    end

    return merged + left + right
  end
end
