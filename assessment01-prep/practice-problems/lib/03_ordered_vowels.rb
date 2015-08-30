def ordered_vowel_words(str)
	vowels = ["a","e","i","o","u"]

	str = str.split(" ");
	new_str = []

	str.each do |word|
		last_vowel_index = 0
		add = true
		word.split("").each do |char|
			if(vowels.include?(char))
				if(last_vowel_index > vowels.index(char))
					add = false
					break;
				else
					last_vowel_index = vowels.index(char)
				end
			end
		end
		if(add)
			new_str << word
		end
	end

	new_str.join(" ")
end
