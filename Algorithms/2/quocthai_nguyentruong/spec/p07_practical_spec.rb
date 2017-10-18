require 'rspec'
require 'p07_practical'

describe '#can_string_be_palindrome?' do
  it "detects whether a string can be configured to a palindrome" do
    result_1 = can_string_be_palindrome?("edified")
    result_2 = can_string_be_palindrome?("apple")
    result_3 = can_string_be_palindrome?("racecar")
    result_4 = can_string_be_palindrome?("noon")

    expect(result_1).to be(true)
    expect(result_2).to be(false)
    expect(result_3).to be(true)
    expect(result_4).to be(true)
  end
end