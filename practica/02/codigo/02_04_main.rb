require_relative "02_04_module_countable"

class CristianSottile
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

	# count_invocations_of ::say_country
	# count_invocations_of ::say_state
end

me = CristianSottile.new

me.count_invocations_of :say_country
me.count_invocations_of :say_state

puts ":say_country invoked? #{me.invoked? :say_country}" # Should put false
puts ":say_state invoked? #{me.invoked? :say_state}" # Should put false
# puts ":say_city invoked? #{me.invoked? :say_city}" # Should raise an exception

puts ":say_country invoked #{me.invoked :say_country}" # Should put 0
puts ":say_state invoked #{me.invoked :say_state}" # Should put 0
# puts ":say_city invoked #{me.invoked :say_city}" # Should raise an exception

puts me.say_country
puts me.say_state
puts me.say_city

puts ":say_country invoked? #{me.invoked? :say_country}" # Should put 1
puts ":say_state invoked? #{me.invoked? :say_state}" # Should put 1
# puts ":say_city invoked? #{me.invoked? :say_city}" # Should raise an exception

puts ":say_country invoked #{me.invoked :say_country}" # Should put 0
puts ":say_state invoked #{me.invoked :say_state}" # Should put 0
# puts ":say_city invoked #{me.invoked :say_city}" # Should raise an exception

puts me.say_country

puts ":say_country invoked? #{me.invoked? :say_country}" # Should put 2

puts ":say_country invoked #{me.invoked :say_country}" # Should put 0