
# Clases y módulos

## 1. Modelar 😍

### Primer enfoque
Clases Auto, Moto y Lancha. Son todas hijas de Vehículo. Las tres entienden el método `arrancar`. Vehículo provee un template method en el método `arrancar`, que invoca a los métodos `pre_arranque` y `arranque_con_llave`. `pre_arranque` tiene una implementación por defecto, en la que no hace nada.

[Primer enfoque](./extras/02_01_first_attempt.rb)

##### ¿Qué descubrí?
* Dentro de los métodos de clase, self es la clase. Dentro de los de instancia, self es la instancia.

### Segundo enfoque
Si quisiera probar motosierras en el taller, requeriría que la motosierra entienda el mensaje `arrancar`. Para ello, podría definirlo, o bien podría extraer toda la funcionalidad relacionada con el arranque en un módulo y luego incluirlo como mixin en cada una de las clases.

Tendría un mixin con los métodos `arrancar`, `pre_arranque` y `arranque_con_llave`, que luego sería incluído por las clases `Vehiculo` y `Motosierra`. Las subclases de `Vehiculo` redefinirían el método `pre_arranque` acorde a sus necesidades.

[Segundo enfoque](./extras/second_attempt.rb)

##### Ahora bien. ¿Es correcto hacer esto?
* **Herencia**: las clases no forman todas parte de una jerarquía, por lo que el enfoque que teníamos de Vehículo como padre deja de ser válido. Tampoco tendría sentido armar una jerarquía en torno a Arrancador, cabe más como una *capacidad* que como una *generalización*.
* **Composición**: podría *sacarse* a otro objeto. Suena un poco antinatural al principio, y da la sensación de que se estaría haciendo solamente para reutilizar el código, pero no parece incorrecto. De todas formas, se siente más acertado usar un mixin; sería como decir *este chabón tiene la capacidad de arrancar, es un arrancable*. **¿Por qué se siente mas acertado?**

## 2. `include` vs `extend`

`include` es un método privado mediante el cual se agrega a una clase los métodos del módulo como métodos de instancia.

`extend` es un método público que agrega los métodos del módulo sólo al receptor. Ejemplos:

* Si enviamos `extend` a un objeto, ese objeto pasará a tener los métodos del módulo como métodos de instancia. Sólo esa instancia de la clase se verá modificada, las demás no.
* Si enviamos `extend` a una clase, esa clase pasará a tener como métodos de clase los métodos del módulo. Como las clases son *una sola*, aquí sí se ve alterada por completo la clase.

##### 1.
```
class Algo
	include UnModulo
end
```

##### 2.
```
class Algo
	extend UnModulo
end
```

## 3. Implementar
> Módulo `Reverso`. Métodos `di_tcejbo` y `ssalc`.

[Código](./codigo/02_03_main.rb)

## 4. Implementar
> Un mixin `Countable` que permita conocer la cantidad de veces que son invocados los métodos en un objeto. Tenemos tres métodos:
>
> * `count_invocations_of(symbol)`: indica que se quiere llevar la cuenta de las invocaciones del método correspondiente al  símbolo recibido.
> * `invoked?(symbol)`: retorna el valor booleano correspondiente.
> * `invoked(symbol)`: retorna la cantidad de veces que fue invocado el método.

###### ¿Qué voy a necesitar?
* Contar la cantidad de llamados que hubo para un símbolo dado. Voy a usar un Hash.
* Ejecutar nuestro código de actualización del Hash cada vez que se invoca a uno de los métodos monitoreados.

###### ¿Cómo lo voy a implementar?
Puedo introducir la ejecución del código de incremento de las invocaciones mediante el método `alias_method`, que permite *renombrar* un método. Para cada símbolo recibido en el método `count_invocations_of` voy a *renombrarlo* a símbolo_orig, y voy a definir el método símbolo (puedo hacer esto porque lo *renombré*), que aumentará el contador correspondiente y luego invocará al método original.

* `count_invocations_of`
	* agrego el símbolo recibido al hash
	* *renombro* el método mediante `alias_method`
	* defino el *nuevo* método mediante `define_method`
* `invoked?` e `invoked`: retorno el valor asociado, claro.

[Código](./codigo/02_04_main.rb)

El siguiente párrafo es la conclusión de por qué mi primer approach no funcionó.

~~En principio había pensado en definir un único método que intercepte a todos aquellos que se *agreguen* mediante `count_invocations_of`. En él se incrementaría el valor del hash correspondiente al símbolo del método invocado. La cosa no era tan simple como me imaginaba. Surgió un problema: ligar todos los métodos que se quisieran monitorizar a nuestro método contador imposibilitaba saber, dentro del contador, cuál era el método que se había invocado, por lo que no servía. Cuestión, decidí agregar un método contador para cada uno que se quiere monitorizar. Esto lo haré mediante el método `define_method`.~~

#### ToDo
* Hacer `count_invocations_of` método de clase.
* Definir `attr_accessor` para `__countable_invocations_amounts`.

#### Dudas
1. ¿Por qué `self.class.define_method` no me deja por ser método privado, y `self.class.send(:define_method)` sí me deja?
2. ¿Por qué carajo `__countable_invocations_amounts` es nil si no pongo la línea `@__countable_invocations_amounts ||= {}` en `count_invocations_of`?

#### Nuevos conocimientos
##### Uso de `alias_method(new_sym, sym)`
Se genera el alias `new_sym` para el método `sym`. Se puede redefinir `sym` y desde él invocar al *viejo* `sym` mediante `new_sym`.

##### Uso de `class_eval` e `instance_eval`
*Escribir algún día*

## 5. Implementar
> Dada la clase abstracta GenericFactory, implementar subclases que permitan crear instancias mediante el mensaje `create` en vez de `new`.

```ruby
Class GenericFactory	def self.create(**args)		new(**args)	end	def initialize(**args)		raise NotImplementedError	end
end
```

### Preanálisis
##### ¿Qué son esos dos * que recibe create como argumento? ¿Doble splat?
Repasando un poco los *splat*, vemos que **cuando estamos definiendo un método** y decimos que un método será *splat*, estamos especificando que los argumentos individuales que se reciban, que pueden ser N, serán todos metidos en un array que se llamará como el nombre luego del "*". Del otro lado, **cuando estamos invocando un método**, vemos que podemos tomar un array y hacerle *splat*, `some_meth(*some_ary)`, con lo que el método estará recibiendo cada elemento de `some_ary` como un argumento individual.

Ahora vamos a lo que nos interesa: ¿qué es este *doble splat*? **Es lo mismo, pero con hashes**. **Cuando *doble spleateamos* un parámetro formal**, estamos indicando que este será un *hash* que contendrá los argumentos recibidos, que deberán ser pares clave valor en forma de `key: value`. **Cuando lo hagamos con un parámetro actual**, provocaremos que el *hash* se transforme en argumentos individuales con forma de par clave valor.

Cuestión, lo que se pretende con la definición de `create(**args)` es recibir como argumentos un conjunto de pares clave valor, y tratarlos como un único hash dentro del método.

Fuente: [firmafon.dk](https://dev.firmafon.dk/blog/drat-ruby-has-a-double-splat/)

##### Argumentos al new
Parece que los argumentos que enviamos a `new` son enviados directamente a initialize. Sí, así es.

### Planteo de la situación
Tengo una clase abstracta que tiene definido un método `create(**args)`, el cual retorna una instancia de la clase, inicializada con los valores que le pasamos. El método `initialize(**args)` es abstracto, y será definido en las subclases. Cada una sabrá cómo debe inicializarse.

Definiré dos subclases: Persona y Auto. **Persona** tendrá *nombre*, *apellido* y *dni*, y **Auto** tendrá *marca*, *modelo* y *color*. Ambas recibirán un *hash* con claves iguales a sus atributos de instancia.

[Código](./codigo/02_05_main.rb)

## 6. Modificación
> Modificar el código anterior para que **GenericFactory** ahora sea un *Mixin*.

[Código](./codigo/02_06_main.rb)

### ToDo
Ver patrones de diseño *Abstract Factory* y *Factory Method*, que es a lo que en realidad apunta el ejercicio.

## 7. Implementar
> Agregar el método`opposite` a **TrueClass** y **FalseClass**, ante el que deben responder el valor contrario al que son.

[Código](./codigo/02_07_oppositable.rb)

## 8. Analizar el script
* constante VALUE = "global"
* módulo A
	* constante VALUE = "A"
	* clase B
		* constante VALUE = "B"
		* método de clase value, ^VALUE
		* método de instancia value, ^"iB"
	* método de módulo value, ^VALUE
* clase C
	* clase D
		* constante VALUE = "D"
		* método de clase value, ^VALUE
	* módulo E
		* método de módulo value, ^VALUE
	* método de clase value, ^VALUE
* clase F, subclase de C
	* constante VALUE = "F"

### 1. ¿Qué imprimiría cada sentencia? ¿De dónde obtiene el valor?
##### `puts A.value`
A es un módulo. Tiene un método de módulo `#value` que retorna el valor de la constante `VALUE`, que en ese "espacio" de código es "A".

##### `puts A::B.value`
B es una clase que se encuentra definida dentro del módulo A. B tiene un método de clase `#value` que retorna el valor de la constante `VALUE`, que para B es "B".

##### `puts C::D.value`
D es una clase que está definida dentro de la clase C. Desconozco cómo acceder a clases internas a otras clases. Vamos a averiguarlo [...]. Se accede igual que con los módulos. O sea que se invocaría al método de clase `#value` de D, que retorna el valor de la constante `VALUE`, que para D es "D".

##### `puts C::E.value`
Acceso al módulo E, que es interior a C, e invoco al método de módulo `value`, que retorna el valor de `VALUE`, que para E es "global".

##### `puts F.value`
F hereda de C. El método de clase `#value` se encuentra en esa herencia. Cuando se lo invoca en F, yo creo que se ejecuta en el contexto de F, por lo que la constante `VALUE` sería "F". Probémoslo [...]. Contrariamente a lo que yo pensaba, `F.value` retornó "global". **QUÉ ONDA**

### 2. ¿Qué pasaría si ejecutases las siguientes sentencias? ¿Por qué?
##### `puts A::value`
Se invocaría al método de módulo `value`, que retorna la constante `VALUE`, que en ese espacio es "A".

Mediante `::` se accede a métodos o constantes de módulos o clases. Si empieza con mayúscula y no tiene parámetros encerrados entre paréntesis, ruby entenderá que se quiere acceder a una constante y no a un método.

Fuente: [stackoverflow](http://stackoverflow.com/questions/2276905/what-does-double-colon-mean-in-ruby)

##### `puts A.new.value`
A es un módulo, no se puede instanciar. Da `undefined method 'new' for A:Module`.

##### `puts B.value`
Pienso que debería no reconocer B, ya que está definida dentro del módulo A. Veremos [...]. Efectivamente: `NameError: uninitialized constant B`.

##### `puts C::D.value`
Toma la clase D dentro de C, e invoca a su método de clase `value`, que retorna `VALUE`, que en ese scope es "D".

##### `puts C.value`
Invoca al método de clase `value` de C, que retorna `VALUE`, que en ese scope es "global".

##### `puts F.superclass.value`
Lo mismo que C.value, dado que el objeto que retorna `F.superclass` es C.

### Aprendizaje
* `self` dentro de un módulo pero fuera de un método de instancia del módulo, se refiere al módulo. O sea, la definición de un método en la que se antepone un `self`, definirá un método de instancia del módulo y no de la clase que incluya al módulo.
* Cómo acceder a una clase interna a otra clase. **Curioso** que se haga de la misma forma que en los módulos, debe haber alguna relación loca entre `Module` y `Class`.
* Tanto `::` como `.` permiten invocar a métodos de un módulo de una clase o un módulo. Además, `::` permite acceder a clases y constantes internas de clases o módulos.