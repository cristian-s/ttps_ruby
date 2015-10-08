
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