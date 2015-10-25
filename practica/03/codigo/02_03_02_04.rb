require 'minitest/autorun'
require 'minitest/spec'

def special_length *all
	all.each { |e| puts "#{e.to_s} -> #{e.to_s.size}" }
end

describe "#special_length" do
	it "sin parámetros" do
		assert_output("") { special_length }
	end

	it "con el String 'Hola' parámetro" do
		assert_output("Hola -> 4\n") { special_length("Hola") }
	end

	it "con el Symbol :Hola como parámetro" do
		assert_output("Hola -> 4\n") { special_length(:Hola) }
	end

	it "con Object, 'String' y :a_symbol como parámetros" do
		assert_output(
			"Object -> 6\n"\
			"String -> 6\n"\
			"a_symbol -> 8\n"
		) { special_length(Object, "String", :a_symbol) }
	end
end