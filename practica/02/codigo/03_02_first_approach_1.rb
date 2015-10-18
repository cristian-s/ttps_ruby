def procesar_hash(hash, &proc)
	hash.inject({}) do |new_hash, (k, v)|
		new_hash[v] = proc.call(k)
		new_hash
	end
end

hash = { 'clave' => 1, :otra_clave => 'valor' }
puts procesar_hash(hash) { |x| x.to_s.upcase }