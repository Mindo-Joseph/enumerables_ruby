module Enumerable
    def my_each
        self.length.times { |i| yield(self[i])}
    end

    def my_each_with_index
       for index in (0..self.length-1)
            yield(self[index],index)
       end
    end

    def my_select
        result = []
        my_each do |item|
            result << item if yield(item)
        end
        result
    end
    
    def my_all?
        result = true
        self.my_each { |i| break result = false unless yield(i)}
        result
        
    end

    def my_any?
        result = false
        self.my_each { |i| break result = true if yield(i)}
        result
    end

    def my_none?
        result = true
        self.my_each { |i| break result = false if yield(i)}
        result
    end

    def my_count(argument)
        counter = 0
        self.my_each { |i| counter += 1 if argument == i}
        counter

    end

    def my_map proc=nil
        result = []
        self.my_each do |item|
            unless block_given?
                result << proc.call(item)
            else
                result << yield(item)
            end
        end
        result
    end




end
my_test = [1,3,-3,600,0,"Str",19.0]

puts "my_each:"
my_test.my_each { |i| print i.to_s + " "}
puts

puts "my_each_with_index:"
my_test.my_each_with_index { |item,index| print [item,index]}
puts

puts "my_select:"
print my_test.my_select { |item| item.is_a? Integer }
puts

puts "my_all?:"
print my_test.my_all? { |item| item.is_a? String}
puts

puts "my_any?:"
print my_test.my_any? { |item| item.is_a? String}
puts

puts "my_none?:"
array = [1,3,4,0,-1]
print array.my_none? { |item| item > 1000}
puts

puts "my_count:"
counter_array = [1,1,3,4,5]
print counter_array.my_count(1)
puts

puts "my_map:"
print [1,2,3,4,5].my_map { |num| num * 2 }
puts 