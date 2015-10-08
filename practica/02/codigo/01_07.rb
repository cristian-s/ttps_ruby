def tirar_dado
	rand 1..6
end

def mover_ficha(fichas, jugador, casilleros = tirar_dado)
	fichas[jugador] += casilleros
	if fichas[jugador] > 40
		puts "Ganó #{jugador}"
		true
	else
		puts "#{jugador} ahora está en el casillero #{fichas[jugador]}"
		false
	end
end

posiciones = {
	"azul" => 0,
	"rojo" => 0,
	"verde" => 0
}

jugadores = posiciones.collect {|(k, v)| k}.shuffle
finalizado = false

until finalizado
	jugadores.each do |jugador|
		break if (finalizado = mover_ficha(posiciones, jugador))
	end
end