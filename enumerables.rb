module Enumerable
  def my_each
    position = 0
    return to_enum unless block_given?

    while position <= length
      yield self[position]
      position += 1
    end
    self
  end

  def my_each_with_index
    position = 0
    return to_enum unless block_given?

    while position < length
      yield self[position], position
      position += 1
    end
    self
  end

  # Define my_select
  def my_select
    result = []
    return to_enum unless block_given?

    my_each do |item|
      result << item if yield item
    end
    result
  end

  def my_all?(argument=nil)
    result = true
    my_each do |item|
      result = (block_given? && yield(item)) || argument === item
      result = true?(item) if !block_given? && !argument
      return false unless result
    end
    result
  end
end
def true?(val = nil)
  return false if val.nil? || !val

  true
end
print [1, true, 'hi', []].my_all?
puts
