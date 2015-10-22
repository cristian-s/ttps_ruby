fibonacci = Enumerator.new do |yielder|
	a, b = 0, 1
	loop do
		yielder << a
		a, b = b, a + b
	end
end

puts fibonacci.first(10)