# Enumeradores
## Introducción
### *Iterators*
Este patrón plantea dos formas principales de iterar de forma transparente sobre una colección:

* **Internamente**: el control está en manos del objeto colección, y la iteración se produce, comúnmente, sobre la totalidad de la misma.
* **Externamente**: el control está en manos del objeto emisor. La iteración no es completada *de una vez*, si no que el emisor solicita los valores cuando los quiere; entre solicitud y solicitud, el receptor queda *parado* esperando que le pidan un nuevo valor.

### `Enumerable`
`Enumerable` es un *mixin* que posee una variedad de métodos que permiten la *iteración interna* mediante la recepción de un *closure*.

### `Enumerator`
La clase `Enumerator` permite la *iteración interna* y *externa* en ruby. La última se lleva a cabo mediante el método `#next`, que retorna el siguiente elemento de la colección. Hay dos formas de obtener un objeto `Enumerator`: 

* Una es a través de los métodos de iteración interna de `Enumerable`, pero invocados sin un *closure*. Esto genera un `Enumerator` que contiene todos los elementos de la colección receptora, y que puede ser iterado de forma externa e incluso de forma interna, ya que `Enumerator` incluye `Enumerable`.
* Otra es mediante el método de Object `#to_enum`, que requiere que el método `#each` esté implementado.
* Otra es mediante la instanciación explícita con `Enumerator.new(&block)`.

### Lazy Enumerators
Cuando se crea un `Enumerator` explícitamente, el bloque que se le pasa debe ser un *productor* de valores, para que se pueda llevar a cabo la iteración externa mediante `#next`. Por ejemplo, podemos tener un enumerator que sepa darnos los primeros tres números naturales:

```ruby
naturals = Enumerator.new do |yielder|
	yielder << 1
	yielder << 2
	yielder << 3
end

naturals.next # 1
naturals.next # 2
naturals.next # 3
naturals.next # StopIteration: iteration reached an end
```

Vemos que el bloque pasado a `Enumerator.new` recibe un parámetro, `yielder`. Cuando se invoca al `yielder` dentro del bloque, se le envía un valor y la ejecución se frena. Luego, cuando, desde el objeto que conoce al enumerator, se invoca a `#next`, la ejecución dentro del bloque continúa desde donde había frenado y hasta el siguiente `yielder`. De esta forma, cuando le decimos `#next` a naturals, ejecuta la sentencia `yielder << 1`, retornando `1` y quedando paralizado. Luego hace lo propio con `yielder << 2` y `yielder << 3`.

Veamos un ejemplo un poco más ambicioso: un enumerator que nos pueda brindar todos los números naturales.

```ruby
naturals = Enumerator.new do |yielder|
	current = 1
	loop do
		yielder << current
		current += 1
	end
end
```

Los números naturales son infinitos, por lo que no podríamos meterlos en una colección. Ese es uno de los beneficios de los *Lazy enumerators*, nos permiten trabajar con colecciones infinitas.

# 1. Implementar
> Fibonnaci con un lazy enumerator

## 2. Responder
> ¿Qué son los *lazy enumerators*?

Son enumeradores que calculan el siguiente valor cuando se lo piden.

> ¿Qué ventaja les ves sobre los enumeradores que no son lazy?

Tienen dos ventajas:

* No necesitan efectuar operaciones sobre una colección entera, sólo sobre el valor actual.
* Debido a lo anterior, sirven para trabajar con secuencias infinitas.

## 3. Implementar
> Extender la clase `Array` con el método `randomly`:
> 
> * Si recibe un bloque, debe invocarlo con sus elementos en orden aleatorio.
> * Si no recibe un bloque, debe retornar un enumerator que retorne los elementos en orden aleatorio.

[Código](./codigo/04_03.rb)

## 4. Modificar
> La implementación de una clase `Image` que permite aplicar filtros a las instancias.
> 
> Actualmente, cada filtro aplicado retorna una nueva imagen. Se quiere que los filtros sólo se apliquen cuando se envíe el mensaje `#header_bytes`.

### Análisis
* La clase consta de una variable de instancia llamada `data` que es una matriz de números.
* Los filtros consisten en aplicar una operación matemática a todos los números de la matriz.
* Los filtros retornan una nueva imagen con la matriz `data` modificada.

Para que los cálculos se hagan sólo cuando se invoque a `#header_bytes`, data debería ser un enumerator en vez de una matriz en las imágenes generadas a partir de un filtro.

En vez de instanciar `Image` con `data.map`, lo hago con un enumerator:

```ruby
def filter
	enum = Enumerator.new do |yielder|
		data.map {|e| e ** 1.2 }
	end
	Image.new enum
```

Así, los filtros retornan una nueva imagen que aplica el filtro de forma lazy sólo cuando se lo piden. Al ser invocado el método `#header_bytes`, se le pide a `data` los primeros 10 elementos; como `data` es ahora un enumerator, los calculará en ese momento. Veamos el caso de que haya muchas imágenes filtradas anidadas:

```ruby
image.filter_a.filter_c.filter_e.header_bytes

a = image.filter_a
ac = a.filter_c
ace = ac.filter_e
result = ace.header_bytes
```

Se produce una cadena interesante:

1. `#ace.header_bytes` le pide a `ace->data` sus primeros 10 elementos. `ace->data` es un lazy enumerator que aplica la operación `e ** 2.2` a los elementos de una colección que conoce llamada `ac->data`.
2. `ac->data` es en realidad un lazy enumerator que aplica la operación `e ** 1.8` a los elementos de una colección que conoce llamada `a->data`.
3. `a->data` es en realidad un lazy enumerator que aplica la operación `e ** 1.2` a los elementos de una colección que conoce llamada `data`.
4. Finalmente, `data` es una colección y contiene una matriz que representa una imagen.

Cuando se invoca a `#ace.header_bytes` se efectúan los cálculos de todos los filtros aplicándose `((data[i] ** 1.2) ** 1.8) ** 2.2` para los primeros diez elementos. El paréntesis más externo corresponde al filtro e sobre todos los anteriores, el siguiente al filtro c sobre el a, y el siguiente al filtro a sobre la imagen original.

### Resolución
[Código](./codigo/04_04.rb)

### Dudas
1. ¿Por qué, si no hago que sea lazy, `#data` me retorna una matriz infinita? *Ver interfaz de matrix*.