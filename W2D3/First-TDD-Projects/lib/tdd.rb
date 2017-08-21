require 'byebug'
# Remove Dups
def my_uniq(arr)
  result = []

  arr.each { |el| result << el unless result.include?(el) }

  result
end

# --------------------------------------------

# Two Sum
class Array

  def two_sum
    result = []
    (0..(self.length - 2)).each do |i|
      ((i + 1)..(self.length - 1)).each do |j|
        result << [i, j] if (self[i] + self[j] == 0)
      end
    end

    result
  end
end


# --------------------------------------------

# My Transpose

def my_tranpose(rows)
  cols = Array.new(rows.length) { Array.new(rows.length) }

  (0...rows.length).each do |i|
    (0...rows.length).each do |j|
      cols[i][j] = rows[j][i]
    end
  end

  cols
end


# --------------------------------------------

# Stock Picker

def stock_picker(stock_prices)
  result = [0, 1]
  most_profitable = stock_prices[1] - stock_prices[0]

  last_index = stock_prices.length - 1
  (0...last_index).each do |i|
    (i + 1..last_index).each do |j|
      if stock_prices[j] - stock_prices[i] > most_profitable
        most_profitable = stock_prices[j] - stock_prices[i]
        result = [i, j]
      end
    end
  end

  result
end
