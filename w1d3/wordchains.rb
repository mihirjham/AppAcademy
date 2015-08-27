class Wordchain

  attr_accessor :dictionary

  def initialize(file_name = 'dictionary.txt')
      @dictionary = File.readlines(file_name).map {|x| x.chomp}
  end

  def adjacent_words(word)
    adj_words = dictionary.select { |x| x.length == word.length}

    adj_words.delete_if do |dict_word|
      i = 0
      differences = 0
      while i < word.length
        if word[i] != dict_word[i]
          differences += 1
        end
        i +=1
      end
      differences > 1
    end

    return adj_words
  end

  def run(source, target)
    @current_words = [source];
    @all_seen_words = {source => nil};

    while(!@current_words.empty?)
      new_current_words = explore_current_words(target);
      # puts(new_current_words.to_s);
      @current_words = new_current_words;
      if(@current_words.include?(target))
        break;
      end
    end
    path = build_path(target);
    puts(path.to_s);
  end

  def explore_current_words(target)
    new_current_words = [];
    @current_words.each do |curr_word|
      adj_words = adjacent_words(curr_word);
      adj_words.each do |adj_word|
        if(!@all_seen_words.include?(adj_word))
          new_current_words.push(adj_word);
          @all_seen_words[adj_word] = curr_word
          if(adj_word == target)
            return new_current_words;
          end
        end
      end
    end
    # new_current_words.each do |new_words|
    #   puts "#{new_words} from #{@all_seen_words[new_words]}"
    # end
    return new_current_words;
  end

  def build_path(target)
    word = target;
    path = [target];
    while(!word.nil?)
      word = @all_seen_words[word];
      path.push(word);
    end
    path.pop;
    return path.reverse;
  end
end
