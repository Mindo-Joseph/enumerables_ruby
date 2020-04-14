module Enumerable
    def my_each
        self.length.times { |i| yield(self[i])}
        self
    end




end
my_test = [1,3,"stuff",0]
my_test.my_each { |i| print i.to_s + " "}