class Array
	def randomly(&block)
		if block_given?
			self.shuffle.each {|element| block.call(element) }
		else
			self.shuffle.to_enum
		end
	end
end

[1, 2, 3, 4, 5, 6].randomly {|e| puts e}

puts

enum = [1, 2, 3, 4, 5, 6].randomly
enum.each {|e| puts e}