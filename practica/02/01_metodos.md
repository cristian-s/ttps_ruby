# Métodos

### 1. Implementá un método que reciba como parámetro un arreglo de números, los ordene y devuelva el resultado.

```
def sort_array ary
	ary.sort
end
```

### 2. Modificá el método anterior para que en lugar de recibir un arreglo como único parámetro, reciba todos los números como parámetros separados.

Queremos recibir una cantidad N de parámetros, insertarlos en un array y ordenarlos. Tenemos dos inconvenientes aquí: no podemos recibir una cantidad variable de argumentos así nomás, y nos da paja agregar a mano los elementos a un array. La variabilidad en el número de argumentos la resuelve ruby con los **splats**: una técnica mediante la cual se unen todos los argumentos que "sobren" y se forma un array, que es como serán tratados dentro del método. En nuestro caso, desde el punto de vista del método recibiríamos sólo un argumento: un array con todos los argumentos efectivamente enviados.

```ruby
def my_sort *splat_array
	splat_array.sort
end
```

### 3. Suponé que se te da el método que implementaste en el ejercicio anterior para que lo uses a fin de ordenar un arreglo de números que te son provistos en forma de arreglo. ¿Cómo podrías invocar el método?

Lo que tenemos acá es la operación inversa a la situación de los argumentos *splat* explicados arriba. En vez de tomar un conjunto de argumentos y "volverlos" un array, tomamos un array y lo volvemos un conjunto de argumentos. Todo esto en el contexto de una invocación a un método. Así, si tuviéramos que invocar al método `#my_sort` teniendo un array ya formado, haríamos esto:

```ruby
ary = [1, 4, 2, 7, 3]
my_sort *ary
```

De igual forma, podríamos hacer directamente:

```ruby
my_sort *[1, 4, 2, 7, 3]
```

### 4. Escribí un método que dado un número variable de parámetros que pueden ser de cualquier tipo, imprima en pantalla la cantidad de caracteres que tiene su representación como String y la representación que se utilizó para contarla.

Supongo que se aspira a que usemos correctamente como una collection (y un Enumerable en este caso) el splat array generado.

```ruby
def special_length *all
	all.each {|e| puts "#{e.to_s} -> #{e.to_s.size}"}
end
```

### 5. Implementá el método `cuanto_falta?` que opcionalmente reciba como parámetro un objeto Time y que calcule la cantidad de minutos que faltan para ese momento. Si el parámetro de fecha no es provisto, asumí que la consulta es para la medianoche de hoy.
	
La kbida es setear un valor por defecto para el parámetro, permitiendo que el mismo sea opcional.

### 6. Analizar el código en busca de problemas

* En cada iteración, todos los jugadores tiran los dados y se mueven. Sólo se chequea si el juego finalizó cuando termina una iteración.
* `finalizado` toma el valor que devuelve mover_ficha. `mover_ficha` retorna un número cuando el jugador no ganó. Los números evalúan a true, por lo que el juego finalizaría luego de la primer iteración, haya ganado alguien o no.
* `posiciones` es un Hash cuyas *keys* son *symbols*, por lo que retornará nil cuando se lo quiera acceder mediante las *keys* del array sobre el que se itera.

### 7. Modificar el código para que ande
[Código](./extras/01_07.rb)