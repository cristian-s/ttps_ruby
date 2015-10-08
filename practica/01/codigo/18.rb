# 3 digits: 999 x 999

results = []
scope = 100
for a in (999 - scope)..999
	for b in (999 - scope)..999
		current = a * b
		results.push(current) if current.to_s == current.to_s.reverse
	end
end

puts results.max