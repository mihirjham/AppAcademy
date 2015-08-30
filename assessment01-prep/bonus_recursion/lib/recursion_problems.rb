#Problem 1: You have array of integers. Write a recursive solution to find the
#sum of the integers.

def sum_recur(array)
	if(array.length < 1)
		return 0;
	end

	array[0] + sum_recur(array.drop(1))
end

#Problem 2: You have array of integers. Write a recursive solution to determine
#whether or not the array contains a specific value.

def includes?(array, target)
	if(array.length < 1)
		return false
	end

	if(array[0] == target)
		return true
	end

	return includes?(array.drop(1), target)
end

# Problem 3: You have an unsorted array of integers. Write a recursive solution
# to count the number of occurrences of a specific value.

def num_occur(array, target)
	if(array.length < 1)
		return 0
	end

	val = 0

	if(array[0] == target)
		val = 1
	end

	return val + num_occur(array.drop(1), target)

end

# Problem 4: You have array of integers. Write a recursive solution to determine
# whether or not two adjacent elements of the array add to 12.

def add_to_twelve?(array)
	if(array.length < 2)
		return false
	end

	if(array[0] + array[1] == 12)
		return true
	end

	return add_to_twelve?(array.drop(1))
end

# Problem 5: You have array of integers. Write a recursive solution to determine
# if the array is sorted.

def sorted?(array)
	if(array.length < 2)
		return true
	end

	if(array[0] > array[1])
		return false
	end

	return sorted?(array.drop(1))
end

# Problem 6: Write a recursive function to reverse a string. Don't use any
# built-in #reverse methods!

def reverse(string)
	if(string.length < 2)
		return string
	end

	return string[string.length-1] + reverse(string[0..string.length-2])
end
