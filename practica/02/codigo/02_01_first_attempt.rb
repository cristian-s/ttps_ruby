class Vehiculo

	def arrancar
		pre_arranque
		arranque_con_llave
	end

	def pre_arranque

	end

	def arranque_con_llave
		puts "#{self.class} - Arrancando usando la llave"
	end
end

class Auto < Vehiculo
	def pre_arranque
		puts "#{self.class} - Sacando freno de mano"
		puts "#{self.class} - Poniendo punto muerto"
	end
end

class Moto < Vehiculo
	def pre_arranque
		puts "#{self.class} - Dando patada"
	end
end

class Lancha < Vehiculo

end

Auto.new.arrancar
Moto.new.arrancar
Lancha.new.arrancar