require 'rspec'
require 'recursion_problems'

describe "#sum_recur" do
  it "returns 0 for an empty array" do
    expect(sum_recur([])).to eq(0)
  end

  it "returns the sum of all numbers in array" do
    expect(sum_recur([1, 3, 5, 7, 9, 2, 4, 6, 8])).to eq(45)
  end

  it "does not modify the original array" do
    original = [1, 3, 5, 7, 9, 2, 4, 6, 8]
    sum_recur(original)
    expect(original).to eq([1, 3, 5, 7, 9, 2, 4, 6, 8])
  end

  it "calls itself recursively" do
    expect(self).to receive(:sum_recur).at_least(:twice).and_call_original
    sum_recur([1, 3, 5, 7, 9, 2, 4, 6, 8])
  end
end

describe "#includes?" do
  it "returns false if the target isn't found" do
    expect(includes?([1, 3, 5, 7, 9, 2, 4, 6, 8], 11)).to be(false)
  end

  it "returns true if the target is found" do
    expect(includes?([1, 3, 5, 7, 9, 2, 4, 6, 8], 9)).to be(true)
  end

  it "does not modify the original array" do
    original = [1, 3, 5, 7, 9, 2, 4, 6, 8]
    includes?(original, 9)
    expect(original).to eq([1, 3, 5, 7, 9, 2, 4, 6, 8])
  end

  it "calls itself recursively" do
    expect(self).to receive(:includes?).at_least(:twice).and_call_original
    includes?([1, 3, 5, 7, 9, 2, 4, 6, 8], 9)
  end
end

describe "#num_occur" do
  it "returns number of times the target occurs in the array" do
    expect(num_occur([1, 1, 2, 3, 4, 5, 5, 4, 5, 6, 7, 6, 5, 6], 5)).to eq(4)
  end

  it "returns zero if target doesn't occur" do
    expect(num_occur([1, 1, 2, 3, 4, 5, 5, 4, 5, 6, 7, 6, 5, 6], 13)).to eq(0)
  end

  it "does not modify the original array" do
    original = [1, 3, 5, 7, 9, 2, 4, 6, 8]
    num_occur(original, 9)
    expect(original).to eq([1, 3, 5, 7, 9, 2, 4, 6, 8])
  end

  it "calls itself recursively" do
    expect(self).to receive(:num_occur).at_least(:twice).and_call_original
    num_occur([1, 3, 5, 7, 9, 2, 4, 6, 8], 9)
  end
end

describe "#add_to_twelve?" do
  it "returns true if two adjacent numbers add to twelve" do
    expect(add_to_twelve?([1, 1, 2, 3, 4, 5, 7, 4, 5, 6, 7, 6, 5, 6])).to be(true)
  end

  it "returns false if no adjacent numbers add to twelve" do
    expect(add_to_twelve?([1, 1, 2, 3, 4, 5, 5, 4, 5, 6, 7, 6, 5, 6])).to be(false)
  end

  it "does not modify the original array" do
    original = [1, 3, 5, 7, 9, 2, 4, 6, 8]
    add_to_twelve?(original)
    expect(original).to eq([1, 3, 5, 7, 9, 2, 4, 6, 8])
  end

  it "calls itself recursively" do
    expect(self).to receive(:add_to_twelve?).at_least(:twice).and_call_original
    add_to_twelve?([1, 3, 5, 7, 9, 2, 4, 6, 8])
  end
end

describe "#sorted?" do
  it "returns true if the array has only one value" do
    expect(sorted?([1])).to be(true)
  end

  it "returns true if the array is empty" do
    expect(sorted?([])).to eq(true)
  end

  it "returns true if the array is sorted" do
    expect(sorted?([1, 2, 3, 4, 4, 5, 6, 7])).to be(true)
  end

  it "returns false if the array is not sorted" do
    expect(sorted?([1, 1, 2, 3, 4, 5, 5, 4, 5, 6, 7, 6, 5, 6])).to be(false)
  end

  it "does not modify the original array" do
    original = [1, 3, 5, 7, 9, 2, 4, 6, 8]
    sorted?(original)
    expect(original).to eq([1, 3, 5, 7, 9, 2, 4, 6, 8])
  end

  it "calls itself recursively" do
    expect(self).to receive(:sorted?).at_least(:twice).and_call_original
    sorted?([1, 3, 5, 7, 9, 2, 4, 6, 8])
  end
end

describe "#reverse" do
  it "reverses strings of length <= 1" do
    expect(reverse("")).to eq("")
    expect(reverse("a")).to eq("a")
  end

  it "reverses longer strings" do
    expect(reverse("laozi")).to eq("izoal")
    expect(reverse("kongfuzi")).to eq("izufgnok")
  end

  it "does not modify the original string" do
    original = "fhqwhgads"
    reverse(original)
    expect(original).to eq("fhqwhgads")
  end

  it "calls itself recursively" do
    expect(self).to receive(:reverse).at_least(:twice).and_call_original
    reverse("fhqwhgads")
  end
end
