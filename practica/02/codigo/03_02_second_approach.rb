def procesar_hash(hash, &proc)
	hash
		.map {|k, v| [v, proc.call(k)]}
		.to_h
end

hash = { 'clave' => 1, :otra_clave => 'valor' }
puts procesar_hash(hash) { |x| x.to_s.upcase }