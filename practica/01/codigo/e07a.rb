#!/usr/local/bin/ruby

def perform_operations str
	puts str.reverse
	
	puts str.tr " ", ""
	
	puts str.bytes.inject "" {
		|result each|
		result + each.to_s
	}
	
	vowels_to_numbers = {
		"a" => 4,
		"e" => 3,
		"i" => 1,
		"o" => 0,
		"u" => 6,
	}
	vowels_to_numbers.to_a.each {|a| vowels_to_numbers[a[0].upcase] = a[1]}

	puts str.gsub /[aeiou]/, vowels_to_numbers
end

vowels_to_numbers.inject({}) do |h, (k, v)|
	h[k] = h[k.upcase] = v
	h
end