def procesar_hash(hash, &proc)
	hash.inject({}) {|new_hash, (k, v)| new_hash.merge({ v => proc.call(k) })}
end

hash = { 'clave' => 1, :otra_clave => 'valor' }
puts procesar_hash(hash) { |x| x.to_s.upcase }