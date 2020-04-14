module Enumerable
  def my_each
    position = 0
    return to_enum unless block_given?
    while position <= length do
      yield self[position]
      position += 1
    end
    self
  end

  def my_each_with_index
    position = 0
    return to_enum unless block_given?
    while position < length do
      yield self[position],position
      position +=1
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

end
print [1,2,3,5].my_select.class == [1,2,3,4,5].select.class
puts 
