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



end
my_test = [1,3,-3,600,0,"Str"]

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
