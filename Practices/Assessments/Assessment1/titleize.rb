# Write a method that capitalizes each word in a string like a book title
# Do not capitalize words like 'a', 'and', 'of', 'over' or 'the'
def titleize(title)
  specical = %w(a and of over or the)

  words_arr = title.split(" ").map do |word|
    !specical.include?(word) ? word.capitalize : word
  end

  words_arr[0].capitalize! if specical.include?(words_arr[0])
  words_arr.join(' ')
end
