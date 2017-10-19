# Heaps and Heapsort

In this project, you'll be implementing a __heap__ and __heapsort__

## Heap

Start by implementing `BinaryMinHeap`. Instances of `BinaryMinHeap` will use an array to store items. Define a default prc for the MinHeap property. You will be able pass in a different prc that will make it behave like a MaxHeap.

Add the `::child_indices` and `::parent_index` methods. The `::child_indices` method should take in a parent index and the length of an array and return only the child indices that fall within the array. The `::parent_index` method should take in a child index and return its parent index.

Once you've completed these methods, it's time to tackle `::heapyify_down`. This method should take in an array, parent index, and a length. If the parent is greater than either of its two children, swap them. Continue swapping the node until it has reached the correct position (aka neither of its children are greater).

Next, implement `::heapify_up`. This method will be used when adding a new element to the heap to make sure that it is in the correct position. It should take an array, a child index, and a length. Check the child against its parent, and swap the elements if the parent is greater. Continue until the node has reached the correct position.

Now that you have `::heapify_up` and `::heapify_down`, it's time to write `#push`, `#peek`, `#extract`, and `#count`. What is the time complexity of each of pushing and extracting from your heap? Once you have all of your specs passing, it's time to sort!

## Heapsort

Let's monkey patch the `Array` class with the `#heap_sort!` method. This method should not create a new array. It should start by heapifying the array in place. Once the items have been heapified, use the `::heapify_down` method to extract items from the heap one by one, moving them past a partition in the array. Voila! Your array has been heap sorted.

What is the time complexity of HeapSort? What is the space complexity?

## K-largest elements

Let's use our BinaryMinHeap to solve a whiteboarding-style question. Given an `array` and an integer `k`, return the k-largest elements in `O(nlogk)` time.
