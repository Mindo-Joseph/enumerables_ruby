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

end
[1,2,3,5].my_each { |i| print i.to_s + " "}
puts 
