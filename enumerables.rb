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

  def my_count(arg = nil)
    count = 0
    if block_given?
      my_each { |i| count += 1 if yield(i) }
    elsif !arg.nil?
      my_each { |i| count += 1 if arg == i }
    else
      return size
    end
    count
  end

  def my_map(proc = nil)
    array = []
    if proc
      my_each { |item| array << proc.call(item) }
    elsif block_given?
      my_each { |item| array << yield(item) }
    else
      return my_each
    end
    array
  end

  def my_inject(arg1 = nil, arg2 = nil)
    array = *self
    result = 0 if array[0].is_a? Numeric
    result = '' if array[0].is_a? String
    result = arg2 if arg2.is_a? Numeric
    if block_given?
      array.my_each { |x| result = yield(result, x) }
    elsif arg2.nil?
      array.my_each { |x| result = result.send(arg1, x) }
    else
      array.my_each { |x| result = result.send(arg2, x) }
    end
    result
  end
end
def multiply_els(array)
  array.my_inject(1, :*)
end
