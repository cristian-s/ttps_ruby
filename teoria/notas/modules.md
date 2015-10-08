# Módulos
Los módulos son unas estructuras loks que pueden contener variables, constantes y métodos. Desde fuera de los módulos, podemos invocar métodos como si fueran clases `.`, y podemos acceder a sus constantes mediante `::`. Andá a saber cómo acceder a las variables.

Podemos usar los módulos de dos formas distintas:
* como **namespaces**
* como **mixins**

## Namespaces
**Leer teoría de namespaces**

## Mixins
Podemos incluir un módulo dentro de una clase. De esta forma, la clase se *apropiaría* de los métodos, variables y constantes del mismo. A esta forma de utilizarlos se la llama *mixin*. Por ejemplo, podríamos hacer a los arrays *sumables* definiendo el mixin

```ruby
module Sumable
	def sum
		inject(:+)
	end
end
```

e incluyéndolo en la clase.

#### ¿Clase o instancia?
Los módulos no tienen métodos de instancia o de clase, sólo métodos. Esto es porque no son clases susceptibles de tener instancias, son simplemente módulos. La cosa es que cuando se incluye un mixin, se agregan sus métodos como métodos de instancia.

#### Runtime
Cuando una clase incluye un mixin, se guarda una referencia al mismo. Cuando le llega un mensaje, este es el orden de *lookup* que sigue:

1. Él mismo, claro
2. Sus mixins
3. Su padre

Al mantener una referencia, cualquier modificación en tiempo real sobre el mixin se verá reflejada en todos los que lo incluyan.

#### Definiendo métodos *para* un mixin
A veces, los mixins necesitan que las clases que lo incluyan implementen algunos métodos para poder proveer su funcionalidad. Por ejemplo, el mixin *Comparable* agrega los métodos `<`, `<=`, `==`, `>=`, `>` y `between?`, entre otros, y para ello requiere que las clases implementen el método `<=>`, que le permite hacer sus comparaciones.

#### ¿Cuándo usar mixins?
La experiencia nos lo dirá.