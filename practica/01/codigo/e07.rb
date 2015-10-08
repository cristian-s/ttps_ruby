#!/usr/local/bin/ruby

def perform_operations str

	puts str.reverse
	
	puts str.tr " ", ""
	
	puts str.bytes.inject("") {
		|result, each|
		result + each.to_s
	}
	
	puts str.gsub /[aeiou]/, /[aA]/ => 4, "e" => 3, "E" => 3, "i" => 1, "I" => 1, "o" => 0, "O" => 0, "u" => 6, "U" => 6
end

perform_operations(ARGV[0] || "This is a default text")