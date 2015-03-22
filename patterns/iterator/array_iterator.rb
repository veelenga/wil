class ArrayIterator
  def initialize(array)
    @array = array
    @index = 0
  end

  def has_next?
    @index < @array.length
  end

  def next
    value = @array[@index]
    @index += 1
    value
  end
end
