def some_method(*args, &proc)
	proc.call(*args)
end

some_method(1, 2, 3, 4) {|a, b, c, d| puts "#{a} #{b} #{c} #{d}"}
# => 1 2 3 4
some_method(1, 2, 3) {|a, b, c, d| puts "#{a} #{b} #{c} #{d}"}
# => 1 2 3
some_method(1, 2, 3, 4, 5) {|a, b, c, d| puts "#{a} #{b} #{c} #{d}"}
# => 1 2 3 4