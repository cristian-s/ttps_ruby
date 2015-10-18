def da_nil?
	yield.nil? if block_given?
end

puts da_nil? { 2 }
puts da_nil? { }
puts da_nil? { nil }
puts da_nil?