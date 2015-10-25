# Excepciones
Cuando tenemos cierto código que sabemos que, dado un conjunto de condiciones, puede producir errores, o que queremos específicamente que produzca un error si se cumplen una serie de requisitos, podemos hacer uso de las excepciones.

Las excepciones nos permiten especificar el código *peligroso* y qué hacer en caso de que se produzcan (o se deban producir) errores.

##### `begin`
Indica el comienzo del código *peligroso*.

##### `raise`
Cuando queremos producir una excepción, usamos el método de `Kernel` `#raise`. Se puede invocar de distintas maneras:

* `raise`: si ya existía una excepción, la relanza. Si no, lanza un `RuntimeError`.
* `raise "some string"`: lanza un `RuntimeError` con el mensaje `"some string"`.
* `raise Exception, "some other string"`: lanza una `Exception` con el mensaje `"some other string"`.
* `raise Exception, "some different string", caller`: como la forma anterior, con el agregado de la pila de ejecución, que se obtiene mediante `Kernel.caller`.

##### `rescue`
Aquí se indica lo que se quiere hacer en caso de que se produzca una excepción. Se especifica cuál es la excepción que se quiere manejar mediante la clase de la misma. La decisión de si entrar o no a un `rescue` está dada por la comparación `arg == $!`. `$!` es el objeto al que se asocia la excepción. Si no se envían parámetros, se compara `$!` con `StandardError`. **Profundizar `$!`, parece que no es tan simple**.

Los `rescue` se pueden anidar, formando una suerte de *case* o *switch*. Incluso tienen un `else`, que no estoy seguro de si se ejecuta cuando hubo una excepción pero ningún `rescue` la manejó, o cuando directamente no hubo excepciones. [...] Después de probar el else, parece que se ejecuta si no hubo excepciones.

##### `ensure`
Este código se ejecutará siempre, sin importar si hubo excepciones o no.

##### `retry`
A veces la corrección de la causa de la excepción puede automatizarse. La cláusula `retry` permite volver a ejecutar el código posterior al `begin`.