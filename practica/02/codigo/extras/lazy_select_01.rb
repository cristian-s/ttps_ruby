fibonacci = Enumerator.new do |yielder|
	a, b = 0, 1
	loop do
		yielder << a
		a, b = b, a + b
	end
end

def lazy_select(enumerator, &block)
	Enumerator.new do |yielder|
		enumerator.each do |elem|
			yielder << elem if block.call(elem)
		end
	end
end

puts lazy_select(fibonacci) {|e| e % 2 == 0}.first(10)