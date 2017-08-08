# Write a method that translates a sentence into pig latin. You may want a helper method.
# 'apple' => 'appleay'
# 'pearl' => 'earlpay'
# 'quick' => 'ickquay'
def pig_latinify(sentence)
  words = sentence.split(' ')
  wordsArr = words.map { |word| translate(word) }
  wordsArr.join(' ')
end

def translate(word)
  vowel = %w(a e i o u qu)
  i = 0
  i += 1 until vowel.include?(word[i])

  i += 1 if (word[i - 1] == 'q')
  word[i..-1] +  word[0...i] + "ay"
end
