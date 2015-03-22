require './array_iterator'

iterator = ArrayIterator.new([1,2,3,4,5])
while iterator.has_next?
  puts iterator.next
end
