require_relative "02_04_Countable"

require_relative "02_04_Platense"

Platense.count_invocations_of :say_country
Platense.count_invocations_of :say_state

me = Platense.new

puts ":say_country invoked? #{me.invoked? :say_country}" # Should put false
puts ":say_state invoked? #{me.invoked? :say_state}" # Should put false
# puts ":say_city invoked? #{me.invoked? :say_city}" # Should raise an exception

puts ":say_country invoked #{me.invoked :say_country}" # Should put 0
puts ":say_state invoked #{me.invoked :say_state}" # Should put 0
# puts ":say_city invoked #{me.invoked :say_city}" # Should raise an exception

puts me.say_country
puts me.say_state
puts me.say_city

puts ":say_country invoked? #{me.invoked? :say_country}" # Should put true
puts ":say_state invoked? #{me.invoked? :say_state}" # Should put true
# puts ":say_city invoked? #{me.invoked? :say_city}" # Should raise an exception

puts ":say_country invoked #{me.invoked :say_country}" # Should put 1
puts ":say_state invoked #{me.invoked :say_state}" # Should put 1
# puts ":say_city invoked #{me.invoked :say_city}" # Should raise an exception

puts me.say_country

puts ":say_country invoked? #{me.invoked? :say_country}" # Should put true

puts ":say_country invoked #{me.invoked :say_country}" # Should put 2