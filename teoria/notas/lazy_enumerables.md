### ¿Cómo es esta movida de la construcción de Enumerators y las secuencias infinitas?

Aparentemente esta es una kbida que viene de la programación funcional, en donde existen los *lazy enumerators*, que permiten iterar colecciones de a un elemento, pidiendo el siguiente elemento con un método, `next` por ejemplo. 

Bien, esto de `next` ya existe con el módulo `Enumerable` en ruby, pero funciona generando un objeto `Enumerator` a partir de una colección ya existente. Lo loco de la construcción *a mano* de `Enumerators` es que podemos establecer la progresión de la secuencia (progresión?) y que esta se vaya calculando *on demand*. A la concha, ¿qué significa esto? Se define la operación que se debe llevar a cabo estando "*parados*" en un elemento para obtener el siguiente. Los `Enumerators` creados explícitamente reciben un bloque que tiene como parámetro un objeto. El código dentro del bloque se ejecuta de a partes: cada vez que se efectúa un `next`, se avanza hasta la sentencia que interactúa con el parámetro; allí queda "congelada" la ejecución hasta que se vuelve a hacer `next`, y lo mismo vuelve a ocurrir. Este objeto puede recibir `:<<` junto con el elemento que se quiere devolver, lo cual funcionaría para cuando queremos iterar mediante `next`, o puede ser un bloque que se invoca envíandole como parámetro el elemento correspondiente.

### Un ejemplo
##### Nota importante: hago una diferenciación entre enviar al `yielder` `:<<` y `yield` pero en la práctica no existe esta diferencia así que no me den bola. Hagan de cuenta que no hice esa diferencia y que la forma de interactuar con el objeto es indistinta. Lo dejo como está por si alguien sabe si tiene sentido lo que digo y me lo quiere hacer saber.

Se quieren obtener números pares. Definimos el `Enumerator` de forma tal que en cada iteración agregue 2 al número anterior. Queremos recorrerlo con next así que optaremos por la opción en que enviamos `:<<` al objeto parámetro.

```
pairs = Enumerator.new do |yielder|
	actual = 0
	loop do
		yielder << actual
		actual += 2
	end
end
```

Ahora tenemos un `Enumerator` que sabe darnos números pares partiendo del 0. Podríamos pedirle los primeros 10 números pares:

```
irb(main):034:0> pairs.first(10) {|e| puts e}
=> [0, 2, 4, 6, 8, 10, 12, 14, 16, 18]
```

Supongamos que ahora queremos que, para cada número par, efectúe una cierta acción. Acá es donde necesitamos los bloques:

```
pairs = Enumerator.new do |yielder|
	actual = 0
	loop do
		yielder.yield actual
		actual += 2
	end
end
```

Así, por ejemplo, podemos decirle `each {|e| puts e}` y nos intentará imprimir todos los elementos, ya que no tiene límite.

### Lazy something
No conformes con tener estas estructuras infinitas, ahora veremos cómo obtener otras estructuras infinitas a partir de ellas. Implementaremos una función *lazy select* que recibirá un enumerator y un bloque como parámetros. Luego generará un enumerator en donde iterará sobre el recibido, evaluará el bloque y sólo tendrá en cuenta aquellos elementos para los cuales el bloque retornó `true`.

```
def lazy_select enumerator, &block
	Enumerator.new do |yielder|
		enumerator.each do |element|
			yielder << element if block.call element
		end
	end
end
```

Se podría ubicar en un lugar más adecuado: un método perteneciente a `Enumerator`:

```
class Enumerator
	def lazy_select &block
		Enumerator.new do |yielder|
			self.each do |element|
				yielder << element if block.call element
			end
		end
	end
end
```

Así, tenemos enumerators que nos permiten aplicarle un `select` y no dejan de ser enumerators.

### Dudas
1. ¿Es lo mismo `#yield` que `#<<`?
2. ¿Tiene que ver Enumerator con el *mixin* Enumerable? ¿Se podría hacer que todos los que incluyan el *mixin* respondan a este *lazy_select*? ¿Es eso lo que en realidad hicimos arriba?