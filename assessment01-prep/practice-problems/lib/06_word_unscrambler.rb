def word_unscrambler(str, words)
	unscrambled = []
	words.each do |word|
		if(str.split("").sort == word.split("").sort)
			unscrambled << word
		end
	end
	unscrambled
end
