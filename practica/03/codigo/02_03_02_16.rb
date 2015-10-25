require "minitest/autorun"
require "minitest/spec"

require_relative "../../02/codigo/03_01.rb"

describe "#da_nil?" do
	it "sin pasar bloque" do
		refute(da_nil?)
	end

	it "pasando un bloque cuya última evaluación da nil" do
		assert(da_nil? { nil })
	end

	it "pasando un bloque cuya última evaluación no da nil" do
		refute(da_nil? { 2 })
	end

	it "pasando un bloque vacío" do
		assert(da_nil? { })
	end
end