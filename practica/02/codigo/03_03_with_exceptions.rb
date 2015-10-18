def some_method(*args, &proc)
	begin
		proc.call(*args)
	rescue RuntimeError
		STDERR.puts "Algo salió mal..."
		:rt
	rescue NoMethodError
		STDERR.puts "No encontré un método: #{$!}"
		:nm
	rescue
		STDERR.puts "¡No sé qué hacer!"
		raise
	else
		:ok
	end
end

puts 'some_method(1, 2, 3, 4) {|a, b, c, d| puts "#{a} #{b} #{c} #{d}"}'
puts some_method(1, 2, 3, 4) {|a, b, c, d| puts "#{a} #{b} #{c} #{d}"}
puts
# => ok
# => 1 2 3 4

puts 'some_method(1, 2, 3) {|a, b, c, d| puts "#{a} #{b} #{c} #{d}"}'
puts some_method(1, 2, 3) {|a, b, c, d| puts "#{a} #{b} #{c} #{d}"}
puts
# => ok
# => 1 2 3

puts 'some_method(1, 2, 3, 4, 5) {|a, b, c, d| puts "#{a} #{b} #{c} #{d}"}'
puts some_method(1, 2, 3, 4, 5) {|a, b, c, d| puts "#{a} #{b} #{c} #{d}"}
puts
# => ok
# => 1 2 3 4

puts 'some_method("hola") {|str| str.no_method}'
puts some_method("hola") {|str| str.no_method}
puts
# => No encontré un método: {mensaje de error original}

puts 'some_method("hola") {|str| refsvservtsertse}'
puts some_method("hola") {|str| refsvservtsertse}
puts
# => ¡No sé qué hacer!