class AIPlayer
  attr_reader :name;
  attr_accessor :num_players, :current_fragment, :strikes;

  def initialize(name)
    @name = name;
    @dictionary = File.readlines('./ghost-dictionary.txt').map {|el| el.chomp};
    @candidate_words = @dictionary.dup;
    @strikes = 0;
  end

  def add_strike
    @strikes += 1;
  end

  def status
    return "GHOST"[0...@strikes];
  end

  def update_candidate_words
    if(current_fragment.empty?)
      return;
    end
    @candidate_words.keep_if do |dictionary_word|
      dictionary_word[0..(current_fragment.length - 1)] == current_fragment
    end
  end

  def current_fragment=(fragment)
    @current_fragment = fragment;
    update_candidate_words;
  end

  def get_guess
    possible_words = Hash.new([]);
    @candidate_words.each do |word|
      letter = word[current_fragment.length];
      if(valid_play?(current_fragment + letter))
        possible_words[letter] += [word];
        #possible_words[letter].push(word);
      end
    end

    possible_words.each do |key, value|
      possible_words[key] = win_probability(value)
    end
    return possible_words.select {|key,value| value == possible_words.values.max}.keys[0];

  end

  def win_probability(ary)
    winning = [];
    losing = [];

    ary.each do |word|
      if(word.length - current_fragment.length == 1)
        losing.push(word);
      else
        winning.push(word);
      end
    end
    return winning.length.to_f/losing.length;
  end

  def valid_play?(string)
    @candidate_words.each do |dictionary_word|
      return true if dictionary_word[0..(string.length - 1)] == string
    end
    false
  end
end
