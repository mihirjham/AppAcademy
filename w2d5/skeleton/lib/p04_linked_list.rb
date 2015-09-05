class Link
  attr_accessor :key, :val, :next

  def initialize(key = nil, val = nil, nxt = nil)
    @key, @val, @next = key, val, nxt
  end

  def to_s
    "#{@key}, #{@val}"
  end
end

class LinkedList
  attr_reader :head

  include Enumerable
  def initialize
    @head = nil
    @tail = @head
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    @head
  end

  def last
    @tail
  end

  def empty?
    @head.nil?
  end

  def get(key)
    each do |node|
      return node.val if node.key == key
    end
    nil
  end

  def include?(key)
    each do |node|
      return true if node.key == key
    end
    false
  end

  def insert(key, val)
    if empty?
      @head = Link.new(key, val, nil)
      @tail = @head
    else
      new_link = Link.new(key, val, nil)
      @tail.next = new_link
      @tail = new_link
    end
  end

  def remove(key)
    if empty?
      return
    end

    if key == @head.key
      @head = @head.next
      return
    end

    previous_node = nil
    current_node = @head
    until current_node.nil?
      break if current_node.key == key
      previous_node = current_node
      current_node = current_node.next
    end

    if current_node == @tail
      @tail = previous_node
      return
    end

    previous_node.next = current_node.next unless current_node.nil?
  end

  def each
    current_node = @head
    until current_node.nil?
      yield(current_node)
      current_node = current_node.next
    end
  end

  # uncomment when you have `each` working and `Enumerable` included
  def to_s
    inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  end
end
