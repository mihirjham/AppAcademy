def range(start, last)

  if start == last
    return [start]
  end

  [start] + range(start + 1, last)
end

def sum_recursive(array)
  return array.first if array.length < 2

  array.shift + sum(array)
end

def sum_iterative(array)
  array.inject(:+)
end

def exponent_rec1(b, n)
  if(n == 0)
    return 1;
  end

  return b * exponent_rec1(b, n-1);
end

def exponent_rec2(b, n)
  if(n == 0)
    return 1;
  end

  if(n == 1)
    return b;
  end

  if(n % 2 == 0)
    return exponent_rec2(b, n/2) ** 2;
  end

  return b * (exponent_rec2(b, (n-1)/2) ** 2);
end

class Array
  def deep_dup
    copy = [];
    self.each do |el|
      if(el.class == Array)
        copy << el.deep_dup
      else
        copy << el
      end
    end
    return copy;
  end
end

def fibonacci(n)
  return [1] if n == 0

  return [1,1] if n == 1

  fibs = fibonacci(n -1)
  return fibs << (fibs[fibs.length-2] + fibs.last)
end

def fibonacci_iterative(n)
  array = [1]
  1.upto(n) do |i|
    if n == 1
      array << 1
    else
      array << (array[array.length - 2] + array.last)
    end
  end

  return array
end

def bsearch(array,target)
  if array.length < 1
    return nil
  end

  mid = array.length/2

  if array[mid] == target
    return mid
  end

  if target < array[mid]
    return bsearch(array[0..mid - 1],target)
  end

  found = bsearch(array[mid+1..(array.length - 1)],target)
  if found == nil
    return nil
  end

  return mid + found + 1
end
#
# def make_change(target, denominations)
#   change = [];
#   possibility = []
#
#   unless denominations.nil?
#   denominations.each_index do |i|
#     if(target % denominations[i] != 0)
#       #print "#{denominations[i]} "
#       possibility += [denominations[i]]*(target/denominations[0])
#       #print "#{possibility.to_s} "
#       make_change(target%denominations[i], denominations[1..(denominations.length - 1)]);
#     else
#       return possibility +[denominations[i]]*(target/denominations[0])
#       #print "#{denominations[i]} "
#     end
#     print "#{possibility.to_s} "
#   end
#   end
#
#   #print "#{possibility.to_s} "
#   puts ""
#   possibility
# end
#
# use denomination and dont drop it unless you dont use it.
#try making change both while dropping it and without dropping it

def make_change(target, denominations)
  denominations_copy = denominations.dup;
  target_copy = target;
  min = [];

  while(denominations_copy.length > 0 && target_copy > 0)
    num = target_copy/denominations_copy[0];
    target_copy = target_copy % denominations_copy[0];
    min += [denominations_copy[0]]*num;
    denominations_copy.shift;
  end

  if(denominations.length > 0)
    change = make_change(target,denominations[1..denominations.length-1]);
  else
    change = []
  end

  if(min.length > change.length && change.length >= 1)
    min = change;
  end
  return min;
end

def merge_sort(array)
  if(array.length <= 1)
    return array;
  end

  left = merge_sort(array[0..(array.length/2-1)]);
  right = merge_sort(array[((array.length/2))..(array.length-1)]);

  return merge(left,right);

end

def merge(left, right)
  i = 0;
  j = 0;
  merged = [];

  while(i < left.length && j < right.length)
    if((left[i] <=> right[j]) == -1)
      merged.push(left[i]);
      i += 1;
    elsif((left[i] <=> right[j]) == 1)
      merged.push(right[j]);
      j += 1;
    else
      merged.push(left[i]);
      merged.push(right[j]);
      i += 1;
      j += 1;
    end
  end

  if(i == left.length)
    merged += right[j..right.length-1];
  else
    merged += left[i..left.length-1];
  end

  return merged;
end

def subsets(array)
  if array.empty?
    return [[]];
  end

  value = array.pop;
  subs = subsets(array);
  added_subs = [];

  # added_subs = subs.map{|el| el + [value]};

  i = 0;
  while(i < subs.length)
    added_subs[added_subs.length] = subs[i] + [value];
    i += 1;
  end

  subs += added_subs;
  return subs;

end
