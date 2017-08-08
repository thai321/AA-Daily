class String
  # Returns an array of all the subwords of the string that appear in the
  # dictionary argument. The method does NOT return any duplicates.

  def real_words_in_string(dictionary)
    arr = []

    0.upto(self.length - 1) do |i|
      dictionary.each do |word|
        if !arr.include?(word) && self[i..-1].start_with?(word)
          arr << word
          i += word.length
        end
      end
    end

    arr
  end
end
