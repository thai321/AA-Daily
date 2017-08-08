require 'byebug'
# make better change problem from class
# make_better_change(24, [10,7,1]) should return [10,7,7]
# make change with the fewest number of coins

# To make_better_change, we only take one coin at a time and
# never rule out denominations that we've already used.
# This allows each coin to be available each time we get a new remainder.
# By iterating over the denominations and continuing to search
# for the best change, we assure that we test for 'non-greedy' uses
# of each denomination.

def make_better_change(value, coins)
  return [value] if coins.include?(value)
  return [] if value <= 0

  possible_changes = []

  coins.each do |coin|
    if value >= coin
      changes = [coin] + make_better_change(value - coin, coins)
      possible_changes << changes
    end
  end

  return [] if possible_changes.empty?
  possible_changes.min_by(&:length)
end
