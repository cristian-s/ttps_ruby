module Arrancable
	
	def arranque_con_llave
		puts "#{self.class} - Arrancando con llave"
	end
	
	def pre_arranque

	end
	
	def arrancar
		pre_arranque
		arranque_con_llave
	end

end

class Vehiculo
	include Arrancable
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

class Motosierra
	include Arrancable
end

Auto.new.arrancar
Moto.new.arrancar
Lancha.new.arrancar
Motosierra.new.arrancar