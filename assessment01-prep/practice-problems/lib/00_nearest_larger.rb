def nearest_larger(arr, idx)
	i = idx - 1
	j = idx + 1

	while(true)
		puts("i: #{i}")
		puts("j: #{j}")
		if(i >= 0 && arr[idx] < arr[i])
			return i;
		end

		if(j <= arr.length-1 && arr[idx] < arr[j])
			return j
		end

		if(i >= 0)
			i -= 1
		end

		if(j <= arr.length-1)
			j += 1
		end

		if(i == -1 && j == arr.length)
			return nil
		end
	end
end
