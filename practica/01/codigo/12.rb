def rot str, n
	lowercase = ("a".."z").to_a
	capital = ("A".."Z").to_a
	(str.chars.collect do |c|
		if /[a-z]/.match(c)
			lowercase.at((lowercase.index(c) + n) % 25)
		elsif /[A-Z]/.match(c)
			capital.at((capital.index(c) + n) % 25)
		else
			c
		end
	end).join
end

puts rot("¡Bienvenidos a la cursada 2015 de TTPS Opción Ruby!", 14)


# Other implementation
def rot2(str, delta=1)
        str.split("").map {|e| [e.ord + delta].pack 'U'}
end

puts rot2("¡Bienvenidos a la cursada 2015 de TTPS Opción Ruby!", 14)
