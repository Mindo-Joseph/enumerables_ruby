module Enumerable
  def my_each
    return to_enum(__method__) unless block_given?
    i = 0
    while i < size
      yield(to_a[i])
      i += 1
    end
    self
  end


  def my_each_with_index
    return to_enum(__method__) unless block_given?
    i = 0
    while i < size
      yield(to_a[i],i)
      i += 1
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
      array.my_each { |x| result = false unless arg === x }
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
      array.my_each { |x| result = true if arg === x }
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
      array.my_each { |x| result = false if arg === x }
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
    if block_given?
      my_each do |item|
        arg1 = arg1.nil? ? to_a[0] : yield(arg1,item)
      end
      arg1
    elsif arg1
      i = arg2.nil? ? 1:0
      accumulator = arg2.nil? ? to_a[0] : arg1
      operator = arg2.nil? ? arg1 : arg2

      while i < size
        accumulator = to_a[i].send(operator, accumulator)
        i+=1
      end
      accumulator
    else
      to_enum(__method__)
    end
  end
end
def multiply_els(array)
  array.my_inject(1, :*)
end


# puts %w[ant bear cat].my_all? { |word| word.length >= 3 } #=> true
# puts %w[ant bear cat].my_all? { |word| word.length >= 4 } #=> false
# puts %w[ant bear cat].my_all?(/t/)                        #=> false
# puts [1, 2i, 3.14].my_all?(Numeric)                       #=> true
# puts [nil, true, 99].my_all?                              #=> false
# puts [].all?                                           #=> true
# print [1,2,3,4,5].my_select { |num|  num.even?  }   #=> [2, 4]
# puts
# puts %w[ant bear cat].my_any? { |word| word.length >= 3 } #=> true
# puts %w[ant bear cat].my_any? { |word| word.length >= 4 } #=> true
# puts %w[ant bear cat].my_any?(/d/)                        #=> false
# puts [nil, true, 99].my_any?(Integer)                     #=> true
# puts [nil, true, 99].my_any?                              #=> true
# puts [].my_any?                                           #=> false
# puts %w{ant bear cat}.none? { |word| word.length == 5 } #=> true
# puts %w{ant bear cat}.none? { |word| word.length >= 4 } #=> false
# puts %w{ant bear cat}.none?(/d/)                        #=> true
# puts [1, 3.14, 42].none?(Float)                         #=> false
# puts [].none?                                           #=> true
# puts [nil].none?                                        #=> true
# puts [nil, false].none?                                 #=> true
# puts [nil, false, true].none?                           #=> false
# ary = [1, 2, 4, 2]
# puts ary.count               #=> 4
# puts ary.count(2)            #=> 2
# puts ary.count{ |x| x%2==0 } #=> 3
# print (1..4).my_map { |i| i*i } 
# puts     #=> [1, 4, 9, 16]
# print (1..4).my_map { "cat"  }   #=> ["cat", "cat", "cat", "cat"]
# puts
# Sum some numbers
# print (5..10).my_inject(:+)                             #=> 45
# puts
# Same using a block and inject
# print (5..10).my_inject { |sum, n| sum + n }            #=> 45
# puts
# Multiply_els test
# print multiply_els([5,6,7,8,9,10])                       #=> 151200
# puts
# Same using a block
# print (5..10).my_inject(1) { |product, n| product * n } #=> 151200
# puts
# find the longest word
# longest = %w{ cat sheep bear }.inject do |memo, word|
  #  memo.length > word.length ? memo : word
# end
# puts longest                                        #=> "sheep"
