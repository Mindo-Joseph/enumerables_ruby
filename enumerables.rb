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

  def my_all?(arg = nil)
    array = *self
    result = true
    if block_given?
      array.my_each { |x| result = false unless yield(x) }
    elsif arg.nil?
      array.my_each { |x| result = false unless x }
    else
      array.my_each { |x| result = false unless arg == x }
    end
    result
  end

  def my_any?(arg = nil)
    array = *self
    result = false
    if block_given?
      array.my_each { |x| result = true if yield(x) }
    elsif arg.nil?
      array.my_each { |x| result = true if x }
    else
      array.my_each { |x| result = true if arg == x }
    end
    result
  end

  def my_none?(arg = nil)
    array = *self
    result = true
    if block_given?
      array.my_each { |x| result = false if yield(x) }
    elsif arg.nil?
      array.my_each { |x| result = false if x }
    else
      array.my_each { |x| result = false if arg == x }
    end
    result
  end
end

print %w[sure trust].my_none?(5) == %w[sure trust].none?(5)
puts
