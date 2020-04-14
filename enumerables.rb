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




end
my_test = [1,3,"stuff",0]

puts "my_each:"
my_test.my_each { |i| print i.to_s + " "}
puts

puts "my_each_with_index:"
my_test.my_each_with_index { |item,index| print [item,index]}
puts

puts "my_select:"
my_test.my_select { |i| i.is_a? Integer}