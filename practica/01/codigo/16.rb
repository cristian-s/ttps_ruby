def suma_rara tope
	(1..tope).to_a.inject(0) do |sum, element| 
		(element % 3).zero? || (element % 5).zero? ? sum + element : sum
	end
end

puts suma_rara ARGV[0].to_i