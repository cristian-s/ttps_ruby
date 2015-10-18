class GenericFactory
	def self.create(**args)
		new(**args)
	end
	def initialize(**args)
		raise NotImplementedError
	end
end

class Person < GenericFactory
	attr_accessor :firstname, :lastname, :carreer
	def initialize(**args)
		self.firstname = args[:firstname] || "Algún nombre"
		self.lastname = args[:lastname] || "Algún apellido"
		self.carreer = args[:carreer] || "Alguna carrera"
	end
end

class Car < GenericFactory
	attr_accessor :brand, :model, :colour
	def initialize(**args)
		self.brand = args[:brand]
		self.model = args[:model]
		self.colour = args[:colour]
	end
end

person = Person.create(
	firstname: "Cristian",
	lastname: "Sottile",
	carreer: "Lic. en Informática")

another_person = Person.create

car = Car.create(
	brand: "Renault",
	model: "R4",
	colour: "white")

puts person.firstname
puts person.lastname
puts person.carreer

puts another_person.firstname
puts another_person.lastname
puts another_person.carreer

puts car.brand
puts car.model
puts car.colour