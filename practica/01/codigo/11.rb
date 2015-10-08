def rot13 str
	lowercase = ("a".."z").to_a
	capital = ("A".."Z").to_a
	(str.chars.collect do |c|
		if /[a-z]/.match(c)
			lowercase.at((lowercase.index(c) + 13) % 25)
		elsif /[A-Z]/.match(c)
			capital.at((capital.index(c) + 13) % 25)
		else
			c
		end
	end).join
end

puts rot13("¡Bienvenidos a la cursada 2015 de TTPS Opción Ruby!")