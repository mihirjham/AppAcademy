require 'byebug'
class StaticArray
  def initialize(capacity)
    @store = Array.new(capacity)
  end

  def length
    @store.length
  end

  def [](i)
    validate!(i)
    @store[i]
  end

  def []=(i, val)
    validate!(i)
    @store[i] = val
  end

  private

  def validate!(i)
    raise "Overflow error" unless i.between?(0, @store.length - 1)
  end
end

class DynamicArray
  attr_reader :count

  include Enumerable


  def initialize(capacity = 8)
    @store = StaticArray.new(capacity)
    @count = 0
    @capacity = capacity
  end

  def [](i)
    return nil if i >= count
    if i < 0
      idx = count + i
      return @store[idx] if idx >= 0
      return nil
    end
    @store[i]
  end

  def []=(i, val)
    if i < 0
      idx = count + i
      @store[idx] = val
    else
      resize! if i > @capacity
      @store[i] = val
    end
    @store
  end

  def capacity
     @store.length
  end

  def include?(val)
    each do |el|
      return true if el == val
    end
    false
  end

  def push(val)
    resize! if @capacity == count
    @store[count] = val
    @count += 1
  end

  def unshift(val)
    resize! if @capacity == count
    i = 0
    prev = @store[i]
    n_el = @store[i+1]

    while i < count
      @store[i+1] = prev
      prev = n_el
      n_el = @store[i+1]
      i += 1
    end

    @store[0] = val
    @count += 1
  end

  def pop
    return nil if count == 0
    @count -= 1
    popped = @store[count]
    @store[count] = nil
    popped
  end

  def shift
    first = @store[0]
    @store[0] = nil
    idx = 1
    while idx < count
      @store[idx - 1] = @store[idx]
      idx +=1
    end
    @count -= 1
    first
  end

  def first
    @store[0]
  end

  def last
    @store[count-1]
  end

  def each
    idx = 0
    while idx < count
      yield(@store[idx])
      idx += 1
    end

  end

  def to_s
    "[" + inject([]) { |acc, el| acc << el }.join(", ") + "]"
  end

  def ==(other)
    return false unless [Array, DynamicArray].include?(other.class)
    return false unless @capacity == other.length

    each_with_index do |el, idx|
      return false unless other[idx] == el
    end
    true
    # ...
  end

  alias_method :<<, :push
  [:length, :size].each { |method| alias_method method, :count }

  private

  def resize!
    new_store = StaticArray.new(@capacity * 2)
    each_with_index do |el, idx|
      new_store[idx] = el
    end
    #@count = @capacity
    @store = new_store
    @capacity *= 2
  end
end
