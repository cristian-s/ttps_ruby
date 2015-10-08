lazy_fibonacci = Enumerator.new do |yielder|
	a, b = 0, 1
	loop do
		yielder << b
		a, b = b, a + b
	end
end

a = []
while (f = lazy_fibonacci.next) <= 4000000
	a.push(f)
end
puts a.inject {|sum, each| each % 2 == 0 ? sum + each : sum}