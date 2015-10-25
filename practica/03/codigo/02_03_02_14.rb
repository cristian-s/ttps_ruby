require "minitest/autorun"
require "minitest/spec"

require_relative "../../02/codigo/02_07_oppositable.rb"

describe TrueClass do
	it "opposite of true should be false" do
		refute(true.opposite)
	end

	it "opposite of opposite of true should be true" do
		assert(true.opposite.opposite)
	end
end

describe FalseClass do
	it "opposite of false should be true" do
		assert(false.opposite)
	end

	it "opposite of opposite of false should be false" do
		refute(false.opposite.opposite)
	end
end