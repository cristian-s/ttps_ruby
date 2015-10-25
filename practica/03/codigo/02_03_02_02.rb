require 'minitest/autorun'
require 'minitest/spec'

def my_sort *splat_array
	splat_array.sort
end

describe "#my_sort" do

	it "array vacío" do
		assert_equal([], my_sort())
	end

	it "array con un elemento" do
		assert_equal([1], my_sort(1))
	end

	it "array con 10 elementos" do
		assert_equal(
			[0, 1, 2, 3, 4, 5, 6, 7, 8, 9], 
			my_sort(6, 1, 8, 5, 7, 4, 3, 0, 9, 2)
		)
	end

end