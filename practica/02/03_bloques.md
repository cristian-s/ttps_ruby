# Bloques
## 1. Implementar
> Un método que reciba un bloque como parámetro, lo invoque y retorne si el valor de retorno del bloque fue `nil`.

### Preanálisis
##### ¿Qué es un *closure*?
Los *closures* son elementos que almacenan una porción de **código** y una porción del **entorno en donde son definidos**.

La idea es escribir código en un lugar y que este luego sea ejecutado en algún otro lado. Este código contenido en un closure probablemente utilice elementos que se conocen en el entorno en que ellos son definidos, pero que no necesariamente serán conocidos en el entorno en que luego sean ejecutados. Por eso es que un closure, además del código, almacena los elementos de su entorno que requiere conocer.

##### ¿Qué es un `Proc`?
La clase `Proc` es una implementación de los closures en ruby. Cuando se instancia un proc, contiene el código y la porción del entorno que necesita para ejecutarlo. Luego el código puede ser ejecutado mediante el método `#call`.

##### ¿Qué es un bloque?
Los bloques son una forma literal de crear elementos que son *como* instancias de `Proc` pero que en realidad no lo son (confuso, sí; algún día lo aprenderé). De hecho, la instanciación de un proc se hace mediante el envío de un bloque al método `#new` de `Proc`.

##### ¿Entonces?
Cuestión, los bloques son closures hechos y derechos, y los procs son closures en forma de objetos.

##### ¿Cómo recibir un bloque en un método?
Todos los métodos en ruby admiten la recepción de un bloque, más allá de sus parámetros. Dentro del método, podemos invocar al bloque mediante `#yield`. También podemos preguntar si se recibió un bloque mediante `#block_given?`, y también podemos crear una nueva instancia de `Proc` mediante `Proc.new` sin enviarle argumentos. Ejemplo:

```ruby
def some_meth
	yield
end

some_meth { puts "hi" }
# would print hi
```

Otra forma es especificar que se recibirá un bloque. Así, podrá ser recibido de la forma descripta anteriormente o como el último de los argumentos (se debe anteponer & en el parámetro formal y en el actual). Esta manera de hacerlo es mucho menos performante. Ejemplo:

```ruby
def some_meth(&some_block)
	some_block.call
end

some_meth { puts "hi" }

some_proc = Proc.new { puts "hi" }
some_meth(&some_proc)
```

### Resolución
[Código](./codigo/03_01.rb)

### Aprendizaje
Ver *Preanálisis*.

## 2. Implementar
> Un método que reciba un hash y un proc y que retorne un nuevo hash con los valores del recibido como claves, y con los valores como resultado de enviar las claves al proc.

### First approach
Armo el hash *on demand* obteniendo los keys y values correspondientes enviándole al proc recibido cada key del hash.

[First approach 1](./codigo/03_02_first_approach_1.rb)

[First approach 2](./codigo/03_02_first_approach_2.rb)

### Second approach
Sería mejor hacer un collect sobre el hash y pasarle el proc. La cosa es que el `collect` de `Hash` retorna un array con el resultado de aplicar el bloque sobre los pares clave valor; ¡no retorna otro hash!

Por otro lado, la clase `Array` permite instanciar un nuevo hash a partir de un array mediante el método `#to_h`. Para ello, cada elemento en el array debe ser un array que contenga dos elementos: el primero será usado como clave y el segundo como valor, creándose un par clave valor para cada subarray del array.

Con las herramientas que tenemos, si logramos obtener un array como el que `#to_h` espera, tendremos el problema resuelto. Con `#map` podemos obtener todos los pares clave valor del hash y armar un array con cada uno de ellos.

[Second approach](./codigo/03_02_second_approach.rb)

Fuente: [chrisholtz.com](http://chrisholtz.com/blog/lets-make-a-ruby-hash-map-method-that-returns-a-hash-instead-of-an-array/)

### Aprendizaje
* `collect` en hashes.

## 3. Implementar
> Un método que reciba un número variable de argumentos y un bloque, y que al ser invocado ejecute el bloque enviándole todos los argumentos. 
> 
> Le ejecución del bloque debe encapsularse manejando excepciones:
> 
> * Si se produce una excepción `RuntimeException`, se imprime `"Algo salió mal..."` y se retorna `:rt`.
> * Si se produce una excepción `NoMethodError`, imprimir `"No encontré un método: ` + mensaje original de la excepción y retornar `:nm`.
> * Si se produce alguna otra excepción, imprimir `"¡No sé qué hacer!"` y relanzar la excepción.
> Si no se producen excepciones, retornar `:ok`.

### Análisis
##### Pasaje y manipulación de parámetros variables
Mediante splats.

##### Excepciones
Para acceder al mensaje anterior uso la variable global `$!`, que calculo que retorna el mensaje de error ante un `#to_s`, porque según entiendo es un objeto que se asocia a la excepción, no sólo un string.

### Resolución
##### Sin manejo de excepciones
[Código](./codigo/03_03_without_exceptions.rb)

##### Con manejo de excepciones
[Código](./codigo/03_03_with_exceptions.rb)
