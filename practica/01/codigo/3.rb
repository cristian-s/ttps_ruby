def reemplazar(s)
        s.gsub('{', 'do').gsub('}', 'end')
end

puts reemplazar("3.times { |i| puts i }")
