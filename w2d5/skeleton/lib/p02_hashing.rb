class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    sum = 0
    self.each_with_index do |element, index|
      sum += element.hash*index
    end
    sum
  end
end

class String
  def hash
    sum = 0
    chars.each_with_index do |char, idx|
      sum += char.ord*idx
    end
    sum
  end
end

class Hash
  def hash
    sum = 0
    keys.each do |key|
      sum += key.hash
    end
    sum
  end
end
