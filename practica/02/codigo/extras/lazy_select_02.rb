fibonacci = Enumerator.new do |yielder|
	a, b = 0, 1
	loop do
		yielder << a
		a, b = b, a + b
	end
end

class Enumerator
	def lazy_select(&block)
		Enumerator.new do |yielder|
			self.each do |elem|
				yielder << elem if block.call(elem)
			end
		end
	end
end

puts fibonacci
	.lazy_select {|e| e % 2 == 0}
	.lazy_select {|e| e > 100000000000}
	.first(10)