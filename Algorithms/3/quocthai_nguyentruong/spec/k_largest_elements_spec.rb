require 'k_largest_elements'

describe "#k_largest_elements" do

  it "returns the correct set of elements" do
    arr1 = [0,1,2,3,4,5,6,7,8,9].shuffle
    result1 = arr1.sort.drop(6)

    arr2 = (0..1000).to_a.sample(400)
    result2 = arr2.sort.drop(390)

    expect(k_largest_elements(arr1, 4)).to match_array(result1)
    expect(k_largest_elements(arr2, 10)).to match_array(result2)
  end

end
