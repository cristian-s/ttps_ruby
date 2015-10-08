def notacion_hexadecimal array
	array.inject("") do |result, element|
		result + element.to_s(16).ljust(2, "0")
	end
end

def notacion_entera array
	array.each.with_index.inject(0) do |sum, (element, index)|
		sum + element * (256 ** index)
	end
end

puts notacion_hexadecimal([0, 128, 255])
puts notacion_entera([0, 128, 255])