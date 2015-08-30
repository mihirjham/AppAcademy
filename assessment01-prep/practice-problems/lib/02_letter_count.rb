def letter_count(str)
	hash = Hash.new(0)

	str = str.split(" ")
	str.each do |word|
		word.split("").each do |char|
			hash[char] += 1
		end
	end
	hash
end
