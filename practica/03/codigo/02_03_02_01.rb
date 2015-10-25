require 'minitest/autorun'
require 'minitest/spec'

def sort_array ary
	ary.sort
end

describe "#sort_array" do

	it "array vacío" do
		assert_equal([], sort_array([]))
	end

	it "array con un elemento" do
		assert_equal([1], sort_array([1]))
	end

	it "array con 10 elementos" do
		assert_equal(
			[0, 1, 2, 3, 4, 5, 6, 7, 8, 9], 
			sort_array([6, 1, 8, 5, 7, 4, 3, 0, 9, 2])
		)
	end

end