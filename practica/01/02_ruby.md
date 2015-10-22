## Ruby

### 1. Formas de instanciar objetos de estos tipos básicos

##### Array
```
Array.new

[ x, y, z ]

x.to_a
x.to_ary
```

##### Diccionario/Hash
```
Hash.new

{ "nombre" => "Cristian",
  "carrera" => "APU" }
  
{ :nombre => "Cristian",
  :carrera => "APU" }

{ nombre: "Cristian",
  carrera: "APU" }
```

##### String
```
String.new("String")

"String"

# Desde diferentes objetos
to_s
```

##### Symbol
```
# Aparentemente no se instancian, directamente se setean
# De hecho new no es un método válido para Symbol
# Lo que empiece con : será un Symbol
:x creará el Symbol :x

# Desde diferentes objetos
to_sym
```

### 2. 
`'TTPS Ruby'.object_id == 'TTPS Ruby'.object_id` devuelve false, porque los strings, si bien tienen el mismo contenido, son creados mediante un literal y generan cada uno un objeto distinto.

### 3.
```
def reemplazar string
	string.gsub("{", "do\n").gsub("}", "\nend")
end
```

### 4. Escribir una función, dados los siguientes requerimientos
Convertir a palabras la hora actual, dividiendo en los siguientes rangos los minutos:
* si el minuto está entre 0 y 10, debe decir "en punto",
* si el minuto está entre 11 y 20, debe decir "y cuarto",
* si el minuto está entre 21 y 34, debe decir "y media",
* si el minuto está entre 35 y 44, debe decir "menos veinticinco" (de la hora siguiente), si el minuto está entre 45 y 55, debe decir "menos cuarto" (de la hora siguiente),
* si el minuto está entre 56 y 59, debe decir "casi las" (y la hora siguiente)

```
def en_palabras time
	case time.min
		when (0..10) then
			"Son las #{time.hour} en punto"
		when (11..20) then
			"Son las #{time.hour} y cuarto"
		when (21..34) then
			"Son las #{time.hour} y media" 
		when (35..44) then
			"Son las #{(time.hour + 1) % 24} menos veinticinco" 
		when (45..55) then
			"Son las #{(time.hour + 1) % 24} menos cuarto" 
		when (56..59) then
			"Son casi las #{(time.hour + 1) % 24}"
	end
end
```

### 5. Escribir una función, dados los siguientes requerimientos
Recibir como parámetro dos string y retornar la cantidad de veces que aparece el segundo string en el primero, sin importar mayúsculas y minúsculas.

```
def contar (universe, target)
	universe.scan(/#{target}/i).size
end
```

### 6. Modificá la función anterior para que sólo considere como aparición del segundo string cuando se trate de palabras completas.

```
def contar_palabras universe, target
	universe.scan(/\b#{target}\b/i).size
end
```

### 7. Implementar:
Dada una cadena cualquiera, y utilizando los métodos que provee la clase String, realizá las siguientes operaciones sobre el string:

1. Imprimilo con sus caracteres en orden inverso.2. Eliminá los espacios en blanco que contenga.3. Convertí cada uno de sus caracteres por su correspondiente valor ASCII.4. Cambiá las vocales por números (a por 4, e por 3, i por 1, o por 0, u por 6).

```
def perform_operations str
	puts str.reverse
	
	puts str.tr " ", ""
	
	puts str.bytes.inject("") {
		|result, each|
		result + each.to_s
	}
	
	str.bytes.join
	
	puts str.gsub /[aeiou]/, /[aA]/ => 4, "e" => 3, "E" => 3, "i" => 1, "I" => 1, "o" => 0, "O" => 0, "u" => 6, "U" => 6
end
```

##### Adicional
Uso interesante del `Enumerable#inject`: aprovechando que le envía al siguiente elemento de la iteración, el objeto que resulta de su operatoria, se puede usar para, por ejemplo, generar un *Hash* de la siguiente forma:

```ruby
	vowels_to_numbers = {
		"a" => 4,
		"e" => 3,
		"i" => 1,
		"o" => 0,
		"u" => 6,
	}
	
	vowels_to_numbers.inject({}) do |new_hash, (key, value)|
		new_hash[key] = new_hash[key.upcase] = value
		new_hash
	end
```

Lo que hacemos es comenzar con un *Hash* vacío, en cada "iteración" agregarle los valores correspondientes (en este caso, dos pares clave-valor para cada par del hash "viejo"), y pasarle el resultado a la siguiente. Así, al finalizar el método, tenemos una estructura generada automáticamente mediante la agregación de elementos a partir de los elementos originales.

### 8. ¿Qué hace el siguiente código?
```
[:upcase, :downcase, :capitalize, :swapcase].map do |meth|      "TTPS Opción Ruby".send(meth)end
```
La función `map` cumple la misma función que `collect`: para cada elemento de la colección, ejecuta el bloque recibido, enviándoselo como parámetro, y agrega el objeto resultante a una colección que luego retorna. La función `send` invoca al método correspondiente al símbolo enviado como primer argumento. Cuestión, en este caso se retornará el string `"TTPS Opción Ruby"` cuatro veces, con ligeras modificaciones:

- `"TTPS OPCION RUBY"`
- `"ttps opcion ruby"`
- `"Ttps opcion ruby"`
- `"ttps oPCION rUBY"`

### 9.
Escribí una función que dado un arreglo que contenga varios string cualesquiera, retorne un nuevo arreglo donde cada elemento es la longitud del string que se encuentra en la misma posición del arreglo recibido como parámetro.

```
def longitud strings_ary
	strings_ary.collect {|s| s.length}
end
```

### 10.
```
def a_ul hash
	"<ul>\
	#{hash.collect {|key, value| "<li>#{key}: #{value}</li>"}.join}\
	</ul>"
end
```

### 11.
`./01_extras/11.rb`

### 12.
`./01_extras/12.rb`

### 15.
##### Métodos
Provee métodos para pedir todos los métodos, así como métodos para consultar por un determinado método.

`Object#methods`, `Object#public_methods`, `Object#protected_methods`, `Object#private_methods`

`Object#method`, `Object#public_method`, `Object#respond_to`

Para conocer los métodos de clase, se le piden los métodos a la clase, y para conocer los métodos de instancia, se le piden los métodos a una instancia de la clase.

##### Atributos
Provee un método `Object#instance_variables` que en este momento no me funciona :(

##### Superclases
La superclase de una clase se puede obtener mediante el método `Class#superclass`.

### 16. Escribí una función que encuentre la suma de todos los números naturales múltiplos de 3 ó 5 menores que un número tope que reciba como parámetro.
Arranqué queriendo hacer un inject con un if simple adentro, algo así:

```
def suma_rara tope
	(1..tope).to_a.inject(0) do |sum, element|
		if (element % 3).zero? || (element % 5).zero?
			puts sum
		end
	end
end
```

Pero resulta que cuando lo ejecutaba me daba que `nil` no entiende el mensaje `+`. Googleando encontré [esto](http://stackoverflow.com/questions/10722913/ruby-inject-with-conditional-in-block), en donde explican que inject, en cada iteración, pasa al siguiente bloque lo que retornó el anterior; cuando el if daba false, retornaba `nil`, y luego se pasaba al siguiente bloque `nil` como `sum`, provocando el problemín. 

Cuestión, el código queda así:

```
def suma_rara tope
	(1..tope).to_a.inject(0) do |sum, element| 
		(element % 3).zero? || (element % 5).zero? ? sum + element : sum
	end
end
```

### 17.
`./extras_01/17.rb`

Profundización sobre los Enumerators en [*Lazy enumerables*](../teoria/notas/lazy_enumerables.md).

### 18. 😦
`./extras_01/18.rb`

## Dudas

1. ¿Qué onda que each_char retorna un *enumerator* si no se le pasa un bloque? ¿Qué haría con el *enumerator*?
2. ¿Por qué no le pude pasar un objeto Hash a String#gsub?
3. ¿Cómo podría mejorar el hash que le paso? Evitando repetir a y A, por ejemplo.

## ToDo
1. Agregar las mayúsculas al hash vowels_to_numbers.