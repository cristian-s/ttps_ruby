require 'minitest/autorun'
require 'minitest/spec'

def longitud strings_ary
	strings_ary.collect {|s| s.length}
end

describe "#longitud" do
	
	it "el array está vacío" do
		assert_equal([], longitud([]))
	end

	it "el array tiene un string de 0 letras" do
		assert_equal([0], longitud([""]))
	end

	it "el array tiene tres strings de 3, 10 y 2 letras" do
		assert_equal([3, 10, 2], longitud(["333", "diezletras", "22"]))
	end

end