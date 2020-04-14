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

    while position <= length
      yield self[position], position
      position += 1
    end
    self
  end
end
