require "quick_sort"

describe QuickSort do
  describe "partition" do
    it "partitions the whole array properly" do
      arr = [3, 1, 5, 2, 4]
      pivot_idx = QuickSort.partition(arr, 0, 5)

      expect(arr[0] && arr[1]).to be < arr[2]
      expect(arr[3] && arr[4]).to be > arr[2]
      expect(pivot_idx).to eq(2)
    end

    it "partitions a portion of the array" do
      arr = [4, 3, 2, 1, 7, 5, 8, 6]
      pivot_idx = QuickSort.partition(arr, 4, 4)
      # Should not touch left half of the array
      expect(arr[0...4]).to eq([4, 3, 2, 1])

      expect(arr[4] && arr[5]).to be < arr[6]
      expect(arr[7]).to be > arr[6]
      expect(pivot_idx).to eq(6)
    end
  end

  describe "sort2!" do
    it "sorts an array" do
      arr = [5, 3, 4, 2, 1, 6]
      QuickSort.sort2!(arr)
      expect(arr).to eq([1, 2, 3, 4, 5, 6])
    end

    it "makes the right number of comparisons (good case)" do
      arr = [4, 2, 1, 3, 6, 5, 7]

      num_comparisons = 0
      QuickSort.sort2!(arr) do |el1, el2|
        num_comparisons += 1
        el1 <=> el2
      end

      # When pivot is first element...
      # If pivot is swapped while iterating through the array,
      # then num_comparisons = 10.
      # If pivot is swapped after iterating through the array,
      # then num_comparisons = 11.
      expect([10, 11]).to include(num_comparisons)

    end

    it "makes the right number of comparisons (worst case)" do
      arr = [1, 2, 3, 4, 5]

      num_comparisons = 0
      QuickSort.sort2!(arr) do |el1, el2|
        num_comparisons += 1
        el1 <=> el2
      end

      # When pivot is first element...
      # If pivot is swapped while iterating through the array,
      # then num_comparisons = 10.
      # If pivot is swapped after iterating through the array,
      # then num_comparisons = 8.
      expect([8, 10]).to include(num_comparisons)
    end
  end
end
