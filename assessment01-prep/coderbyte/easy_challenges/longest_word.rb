def LongestWord(sen)

  # code goes here
  sen = sen.split(" ")
  hash = {}
  sen.each_with_index do |word, i|
    lower_word = word.downcase
    lower_word = lower_word.split("")
    lower_word -= (lower_word - ("a".."z").to_a)
    hash[lower_word.join("")] = i
  end
  
  max_length = hash.keys.sort_by {|k| k.length}.last.length

  hash = hash.select {|k,v| k.length == max_length}
  sen[hash.values.sort[0]]

end

puts(LongestWord("I love dogs"))