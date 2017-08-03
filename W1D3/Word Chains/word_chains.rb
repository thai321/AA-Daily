require 'set'

class WordChainer
  attr_reader :dictionary
  def initialize(file)
    @dictionary = make_dictionary(file)
  end

  def make_dictionary(file)
    File.readlines(file).map(&:chomp).to_set
  end

  def adjacent_words(word)
    words = []

    word.each_char.with_index do |char, i|
      ('a'..'z').each do |new_char|
        if new_char != char
          new_word = word.dup
          new_word[i] = new_char
          words << new_word if @dictionary.include?(new_word)
        end
      end
    end

    words
  end

  def build_path(target)
    path = []
    current = target
    until @all_seen_words[current].nil?
      path << current
      current = @all_seen_words[current]
    end

    path.reverse
  end

  def run(source, target)
    @current_words = [source]
    @all_seen_words = { source => nil }

    until @current_words.empty?
      explore_current_words
    end

    [source] + build_path(target)
  end

  def explore_current_words
    new_current_words = []

    @current_words.each do |current_word|
      adjacent_words(current_word).each do |adjacent_word|
        if !@all_seen_words.include?(adjacent_word)
          @all_seen_words[adjacent_word] = current_word
          new_current_words << adjacent_word
        end
      end
    end

    # p @all_seen_words
    @current_words = new_current_words
  end
end


if __FILE__ == $PROGRAM_NAME
  file = 'dictionary.txt'
  wordChains = WordChainer.new(file)
  p wordChains.run("thai", "love")
end
# path from "thai" to "love"
# ["thai", "that", "chat", "coat", "cost", "lost", "lose", "love"]
