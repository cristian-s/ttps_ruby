class Platense
	include Countable

	def say_country
		puts "My country is Argentina"
	end

	def say_state
		puts "My state is Buenos Aires"
	end

	def say_city
		puts "My city is La Plata"
	end

	# count_invocations_of :say_country
	# count_invocations_of :say_state
end