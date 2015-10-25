# Testing
## 1. Responder
> * ¿En qué consiste la metodología TDD?
> * ¿En qué se diferencia con la forma tradicional de escribir código y luego realizar los tests?

TDD es un proceso de desarrollo que plantea la implementación de los tests de una funcionalidad antes que la implementación de la funcionalidad misma. El ciclo de desarrollo de una funcionalidad consiste en:

1. **Implementar los tests**. La implementación temprana de los tests provoca que la atención sobre los requerimientos se ponga antes de escribir el código, y no después, como suele pasarnos.
2. **Correr los tests**. Dado que la funcionalidad todavía no está implementada, los tests deberían fallar. Si no fallan, probablemente los tests están mal.
3. **Escribir el código de la funcionalidad**. La intención es pasar los tests. El código puede no ser elegante.
4. **Correr los tests**. Aquí se prueban los resultados del código escrito. Si no pasan, se debe volver al paso anterior, claro.
5. **Refactorizar el código**. Aparentemente, es importante que en el paso 3 el código escrito sea feo. Luego de que los tests pasan, el código debe refactorizarse en virtud de que sea legible, mantenible y reusable.

Este ciclo le da al desarrollador la confianza de que su código es correcto y de que sabrá al instante si alguno de los cambios introducidos rompió funcionalidad anterior, ya que se corren *todos* los tests al agregar nuevas funcionalidades.

La principal diferencia con la forma tradicional es la misión del test dentro del ciclo:

* En TDD, primero se escriben los tests, dándole mucha importancia a los requerimientos, ya que ellos son los que definen qué testear y cuáles son los resultados que deberían obtenerse. Los tests aquí **son la base** del desarrollo de la funcionalidad.
* En la forma tradicional, primero entendíamos los requerimientos a nuestro modo, implementábamos la funcionalidad, y luego escribíamos los tests para verificar que esté bien lo que ya hicimos. Los tests son una herramienta para comprobar nuestro trabajo a posteriori, sesgada por nuestro propio entendimiento del mismo.

Fuente: [wikipedia](https://en.wikipedia.org/wiki/Test-driven_development)

## 2. Implementar
> Dado el test, implementar los métodos faltantes *para que pasen los tests*.

[Código](./codigo/02_02.rb)

## 3. Implementar
> Al menos 3 tests para los ejercicios:

* Práctica 1
	* 4
	* [5](./codigo/02_03_01_05.rb)
	* [6](./codigo/02_03_01_06.rb)
	* [9](./codigo/02_03_01_09.rb)
* Práctica 2
	* [1](./codigo/02_03_02_01.rb)
	* [2](./codigo/02_03_02_02.rb)
	* [4](./codigo/02_03_02_04.rb) [multiline strings](http://stackoverflow.com/questions/2337510/ruby-can-i-write-multi-line-string-with-no-concatenation)
	* [14](./codigo/02_03_02_14.rb)
	* [16](./codigo/02_03_02_16.rb)

## 4. Implementar
> Tests para el *Mixin* `Countable`. Se debe cubrir:
> 
> * Una clase existente.
> * Una clase creada con el propósito de ser testeada.
> * Qué ocurre previo a la invocación al método sobre el que se cuentan las invocaciones.
> * Inicialización correcta del *Mixin*.
> * Algún caso extremo.

