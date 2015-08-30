def bubble_sort(arr)
	while(true)
		i = 0
		swapped = false
		while(i < arr.length-1)
			if(arr[i] > arr[i+1])
				arr[i], arr[i+1] = arr[i+1], arr[i]
				swapped = true
			end
			i += 1
		end
		if(!swapped)
			break
		end
	end
	arr
end
