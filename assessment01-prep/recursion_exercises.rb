def range(i, j)
	if(i > j)
		return []
	end

	return [i] + range(i+1,j)
end

def sum_rec(ary)
	if(ary.length < 2)
		return ary.first
	end

	return ary.first + sum_rec(ary.drop(1))
end

def sum_iter(ary)
	ary.inject(:+)
end

def exp(b,n)
	if(n == 0)
		return 1
	end

	if(n == 1)
		return b
	end

	if(n % 2 == 0)
		val = exp(b, n/2)
		return val*val
	else
		val = exp(b, (n-1)/2)
		return b * val * val
	end

end

class Array
	def deep_dup
		ary = []
		self.each do |el|
			if(el.class == Array)
				ary += [el.deep_dup]
			else
				ary << el
			end
		end
		return ary;
	end
end

def fibonacci_rec(n)
	if(n == 1)
		return [1]
	end

	if(n == 2)
		return[1, 1]
	end

	fibs = fibonacci_rec(n-1)

	fibs << fibs[fibs.length-2] + fibs[fibs.length-1]
end

def bsearch(array, target)

	if(array.nil? || array.length < 1)
		return nil
	end

	mid = array.length/2

	if(array[mid] == target)
		return mid
	end

	if(target < array[mid])
		return bsearch(array[0...mid], target)
	end

	if(target > array[mid])
		val =  bsearch(array[mid+1..array.length-1], target)
		if(val.nil?)
			return nil
		end
		val + mid + 1
	end
end

def make_change(target, coins=[10,7,1])
	if(target == 0)
		return []
	end

	best_change = nil;

	coins.each do |coin|
		if(coin > target)
			next
		end

		new_change = make_change(target-coin, coins)
		change = [coin] + new_change

		if(best_change.nil?)
			best_change = change
		else
			if(best_change.length > change.length)
				best_change = change
			end
		end
	end

	return best_change;
end

class Array
	def merge_sort
		if(self.length < 2)
			return self
		end

		left = self[0...self.length/2].merge_sort
		right = self[self.length/2...self.length].merge_sort

		Array.merge(left,right)
	end

	def self.merge(left, right)
		merged = []

		until left.empty? || right.empty?
			if(left.first < right.first)
				merged << left.shift
			elsif(right.first < left.first)
				merged << right.shift
			else
				merged << left.shift
				merged << right.shift
			end
		end
		merged + left + right
	end
end

def subsets(array)
	if(array.length < 1)
		return [[]]
	end
	
	val = array.pop
	subs = subsets(array)

	subs.each do |el|
		subs += [el + [val]]
	end

	return subs
end