# Gemas y Bundler

## 1. Responder
### ¿Qué es una gema?
Una gema es un paquete con código ruby que puede consistir en una librería, un framework o una aplicación.

### ¿Para qué sirven?
Sirven para lo mismo que las librerías o frameworks: reutilizar código, a la vez de poder incluir código de terceros en el nuestro.

### ¿Qué estructura tienen?
Como dijimos, las gemas son paquetes; incluyen *código*, *documentación* y un *gemspec*. La estructura que presentan es la siguiente:

* Directorio **bin**: contiene un ejecutable que será incluído en el PATH del usuario para luego poder ser ejecutado.
* Directorio **lib**: contiene el código de la gema.
* Directorio **test** o **spec**: contiene el código de los tests.
* Archivo **README**: contiene cierta documentación introductoria: cómo instalar, dependencias, cómo usar, etc. Documentación más específica suele incluirse directamente en el código.
* Archivo **Rakefile**: no es obligatorio; contiene instrucciones utilizadas por la gema *Rake* para automatizar y realizar tareas. *Rake* es una implementación en ruby de Make.
* **gemspec**: contiene información sobre la gema: *nombre*, *versión*, *licencias*, *autores*, *archivos*. Se expresa en código ruby, mediante la clase `Gem::Specification`. La información que se puede configurar se documenta en las guías de *rubygems* [[specification-reference]](http://guides.rubygems.org/specification-reference/). Puede ser un archivo en la raiz o incluirse en el Rakefile.

## 2. Investigar
### `gem`
Es *el* gestor de gemas. Es un comando cuyos subcomandos permiten manipular gemas en nuestro sistema y/o proyecto.

Los subcomandos más frecuentemente utilizados son:

* `search some_gem`: búsqueda de gemas. `some_gem` puede ser una expresión regular.
	* `-r`/`--remote`: búsqueda en el repositorio remoto de RubyGems.org. *Default behavior*.
	* `-l`/`--local`: búsqueda en las gemas instaladas.
	* `-d`: información detallada sobre la gema.
* `install some_gem`: instala `some_gem` y sus dependencias.
* `require`: ...
* `list`: lista las gemas instaladas locamente.
* `uninstall some_gem`: desinstala `some_gem`; si la misma es dependencia de otra gema, pedirá confirmación.
* `server`: inicia un servidor web en la dirección http://localhost:8808, en el que se puede encontrar documentación de las gemas instaladas.
* `fetch`: descarga la gema (un paquete .gem) sin instalarla.
* `unpack`: extrae el contenido de una gema (.gem).

En el sitio RubyGems.org puede encontrarse la [lista completa de comandos](http://guides.rubygems.org/command-reference/#gem-update).

### Bundler
Bundler es, así como `gem`, un gestor de gemas, pero, a diferencia de este, está orientado a proyectos y no al sistema en general, por lo que resulta correcto llamarlo *gestor de dependencias*. Su funcionamiento dentro de un proyecto es más o menos así:

* En la raiz del proyecto, se agrega un archivo `Gemfile` en el que se indican las gemas que este necesita junto con un rango de versiones aceptadas. Bundler provee un DSL para este, permitiendo diferentes opciones.
	* [Opciones del Gemfile](./extras/gemfile.md)
	* [gemfile webpage](http://bundler.io/v1.10/gemfile.html)
	* [gemfile man](http://bundler.io/v1.10/man/gemfile.5.html)
* El comando `bundle install` *resuelve* las dependencias especificadas en el `Gemfile`, *instala* las gemas necesarias y genera un archivo llamado `Gemfile.lock`.
	* La *resolución* de una dependencia consiste en determinar una gema y una versión compatibles, así como las gemas de las cuales depende la primera. O sea, se parte de una gema y un rango de versiones, y se obtienen N gemas con sus respectivas versiones. ~~Así, por ejemplo, la dependencia `gem 'nokogiri', '~> 1.6.1'` podría resolverse en la gema `nokogiri 1.7.2`, que es perfectamente compatible, y todas aquellas gemas de las que depende junto con sus versiones.~~
	* La *instalación* **PROBABLEMENTE** consiste en la obtención de la misma, ubicándola en algún directorio accesible para los proyectos, y linkeándola luego en el proyecto. Para aquellas gemas ya instaladas, la obtención no es necesaria.
	* En `Gemfile.lock` se especifican las dependencias resueltas. Si al momento de ejecutar `bundle install` existe un `Gemfile.lock`, se saltea la resolución y se procede con la instalación para todas aquellas dependencias que no hayan sido modificadas en el `Gemfile` luego de la creación del `Gemfile.lock`. Este archivo permite que en todos los repositorios en los que se corra `bundle install`, se instalen las mismas versiones de las gemas.
	* [bundle install man](http://bundler.io/v1.10/man/bundle-install.1.html)
* Una vez en la app, debemos requerir las gemas que vayamos a utilizar. Lo podemos hacer de a una, ejecutando, por ejemplo, `require 'rails'; require 'nokogiri'`, o todas al mismo tiempo, ejecutando `Bundler.require`.

Un *resumen* del proceso de utilización de Bundler puede encontrarse en la sección [Purpose and Rationale](http://bundler.io/rationale.html).

##### Yapa

El comando `bundle exec X` ejecuta el script X en el contexto del Bundler actual; es decir, el script correspondiente a la versión de la gema que contiene el proyecto actual.

## 3. Responder

### ¿Dónde instala las gemas `gem`?

`gem` instala las gemas dentro de un directorio correspondiente a una versión de ruby, lo que me da a entender que para cada versión de ruby, tiene su propio conjunto de gemas. Dentro del directorio de la versión, a su vez, puede ubicar la gema en dos lugares distintos (dependiendo de **andá a saber qué**):

* `lib/ruby/x.y.z` (supongo que es uno de los directorios importantes)
* `lib/ruby/gems/x.y.z/gems/#{gem_name}/lib`

Ejemplos:

```
~/.rbenv/versions/2.2.3/lib/ruby/2.2.0/x86_64-darwin13/bigdecimal.bundle
~/.rbenv/versions/2.2.3/lib/ruby/gems/2.2.0/gems/bundler-1.10.6/lib/bundler.rb
~/.rbenv/versions/2.2.3/lib/ruby/2.2.0/json.rb
~/.rbenv/versions/2.2.3/lib/ruby/gems/2.2.0/gems/minitest-5.4.3/lib/minitest.rb
~/.rbenv/versions/2.2.3/lib/ruby/gems/2.2.0/gems/power_assert-0.2.2/lib/power_assert.rb
~/.rbenv/versions/2.2.3/lib/ruby/2.2.0/psych.rb
~/.rbenv/versions/2.2.3/lib/ruby/2.2.0/rake.rb
~/.rbenv/versions/2.2.3/lib/ruby/2.2.0/rdoc.rb
~/.rbenv/versions/2.2.3/lib/ruby/gems/2.2.0/gems/test-unit-3.0.8/lib/test-unit.rb
```

### ¿Dónde instala las gemas Bundler?

Entiendo que Bundler gestiona las dependencias, linkeando apps a gemas, por lo que me imagino que las gemas estarán instaladas en el mismo lugar de siempre. Lo verificaré cuando esté dentro de algún proyecto con bundler.

## 4. Responder
### ¿Para qué sirve el comando `gem server`? ¿Qué información provee?
`gem server` inicia un servidor en localhost:8808 en el que se presenta documentación de las gemas instaladas.

## 5. Investigar y responder
### Semantic Versioning
Es un estándar de especificación y evolución de las versiones de productos de software. Surge como una reducción del problema denominado *dependency hell*.

Las dependencias pueden volverse una parte importante de las aplicaciones. Cuando una dependencia se actualiza, uno podría chequear que los cambios introducidos no resulten incompatibles con su proyecto. Si este tiene muchas dependencias, y hubiera que chequear cada una en cada actualización, o bien actualizar las dependencias y esperar que salga todo bien, o bien no actualizar, o bien actualizar sólo las dependencias que necesitamos que se actualicen, pero que también requerirían actualizar otras dependencias que tenemos, entonces deberíamos revisar estas también... Bien, eso es *dependency hell*, la situación en la que la gestión de las dependencias dificulta el avance del proyecto.

**Semantic Versioning** propone una sintáxis y semántica para la representación de versiones de aquellos productos de software que proveen una API pública: **X.Y.Z**. **X** es el dígito **major**, **Y** el dígito **minor** y **Z** el dígito **patch**, y se ven modificados de la siguiente manera:

* **Z**
	* *DEBE* incrementarse cuando:
		* Se introducen *bug fixes* compatibles con versiones anteriores. Por *bug fix* se entiende a modificaciones en el software que corrige comportamiento incorrecto.
* **Y**
	* *DEBE* incrementarse cuando:
		* Se introduce nueva funcionalidad compatible hacia atrás.
		* Se marcan como deprecados métodos de la API pública.
	* *PUEDE* incrementarse cuando:
		* Se agrega una cantidad notable de funcionalidad interna.
		* Se realiza una cantidad sustancial de mejoras internas.
	* *PUEDE* incluir:
		* *Patch level changes* (bug fixes).
	* Cuando es incrementado, **Z** *DEBE* resetearse a 0.
* **X**
	* *DEBE* incrementarse cuando:
		* Se introducen cambios en la API pública que no son compatibles hacia atrás.
	* *PUEDE* incluir:
		* *Minor y/o patch level changes*.
	* **Y** y **Z** *DEBEN* resetearse a 0 cuando es incrementado.

Así, la finalidad es que los números indiquen qué tipo de cambios se han introducido en el software, permitiendo comprender a partir de ellos la envergadura de la actualización, qué clase de modificaciones esperar, y cuál será la compatibilidad hacia atrás. 

##### Ejemplo

utilizando Semantic Versioning, mi aplicación *MyApp* podría especificar como dependencia a *AnotherApp* en su versión `2.4.0`. Suponiendo que utilizo métodos de la API pública de *AnotherApp* que fueron introducidos en la versión `2.4.0`, yo podría estar tranquilo de que mientras la versión que yo utilice sea ≥ `2.4.0` y < `3.0.0`, mi código funcionará, ya que todos los cambios introducidos serán compatibles hacia atrás.

La documentación detallada sobre cómo utilizar este sistema se encuentra en el sitio oficial [SemVer.org](http://semver.org/).

##### Yapa

Las aplicaciones suelen iniciarse en la versión `0.1.0`. Mientras la API es inestable y el software no es utilizado en producción, se puede mantener el *major version* en 0. Cuando la aplicación llega a producción, la API es estable con usuarios dependiendo de ella, o el durante el desarrollo se tiene mucho en cuenta la compatibilidad hacia atrás, el *major version* debería ser > `0`.

## 6. Codear

### Ejecución de `ruby prueba.rb` vs `bundle exec ruby prueba.rb`
El primero arroja la excepción `cannot load such file -- colorputs (LoadError)`, mientras que el segundo supone que faltan instalar gemas y recomienda correr `bundle install`.

## 7. Contestar
### i. `Gemfile`
> ¿Qué finalidad tiene el archivo `Gemfile`?

En el archivo `Gemfile` se especifican las dependencias del proyecto, que serán *instaladas* (puede que ya se encuentren instaladas, en cuyo caso sólo serán linkeadas) al ejecutar `bundle exec`.

### ii. `source` en `Gemfile`
> ¿Para qué sirve la directiva `source` del `Gemfile`? ¿Cuántas pueden haber en un mismo archivo?

Sirve para especificar de dónde obtener las gemas. Supongo que puede haber las que se quieran, lo confirmaremos. [...] No lo confirmaremos, pero ya que la directiva `source` acepta bloques con directivas `gem`, no veo por qué habría un límite.

### iii. La gema `colorputs`
> ¿Qué versión se instaló de la gema?

Se instaló la versión `0.2.3`, que presumiblemente es la última ya que no se especificó otra cosa.

> Si mañana se publicara la versión `7.3.2`, ¿esta se instalaría en tu proyecto? ¿Por qué?

Si ejecutara un `bundle update`, se instalaría la última versión de la gema, se cual fuere; ya que no se determinaron rangos válidos para las versiones, se actualizará a la última que exista. O sea, sí.

> ¿Cómo se podría limitar la versión a instalar y que sólo se instalen *releases* en las que no cambie el *major number* de la misma?

Agregando el argumento `"~>0.y"` estaríamos especificando que se actualice la gema mientras que el major number se mantenga en 0.

### iv. `prueba.rb`
> ¿Qué ocurrió la primera vez que ejecutaste `prueba.rb`? ¿Por qué?

Al ejecutar `ruby prueba.rb`, se intentó levantar la gema desde las gemas instaladas por `gem`. Como no se encontraba instalada, lanzó una excepción `LoadError`.

Al ejecutar `bundle exec ruby prueba.rb`, se intentó levantar la gema que se encuentra *instalada* en el proyecto. Como no se ejecutó aún `bundle install`, la gema no se encuentra *instalada* en el proyecto y Bundler indica que no la encuentra.

### v. `bundle install`
> ¿Qué cambió al ejecutar `bundle install`?

`bundle install` resolvió las dependencias especificadas en `Gemfile`, determinando una versión para `colorputs`, instalándola si no se encontraba entre las gems y luego indicando que se debe usar esa versión de esa geme en el proyecto actual.

### vi. `bundle install` vs `bundle update`
> ¿Qué diferencia hay entre `bundle install` y `bundle update`?

##### `bundle install`
Este comando determina su operatoria a partir de la existencia del archivo `Gemfile.lock`.

Si no existe, las dependencias especificadas en `Gemfile` deben ser resueltas: se toma una gema y las restricciones de rango de la versión, y se obtiene una versión concreta desde el `source`; esto se lleva a cabo para cada gema y sus dependencias. Luego en el archivo `Gemfile.lock` se almacena la versión de cada gema *concreta* obtenida.

Si existe, significa que las dependencias en `Gemfile` ya han sido resueltas. Se procede entonces a instalar todas las gemas especificadas en `Gemfile.lock`.

Si existe pero `Gemfile` ha sido modificado luego de la creación de este, se procede a resolver las gemas que han cambiado. Si se encuentra que una de ellas requiere la actualización de una gema que también es dependencia de otra gema, la resolución de dicha gema es abortada.

##### `bundle update`
Este comando ignora la existencia de un `Gemfile.lock` y resuelve todas las dependencias en `Gemfile`.

Puede ser usado de forma tal de sólo actualizar una gema y sus dependencias. Por ejemplo, `bundle update nokogiri` actualizaría `nokogiri` y todas sus dependencias, sin importar si estas también son dependencia de otras gemas.

##### Cuestión
Un posible flujo de trabajo sería:

1. Escribo el `Gemfile`
2. Corro `bundle install`
3. Hago alguna modificación sobre `Gemfile`
	4. **Duda**: esta modificación podría ser el cambio de una versión en una gema o la agregación de una nueva gema. En el segundo caso:
		5. ¿Podría generar conflicto `bundle install`?
		6. Si generara conflicto, ¿cuál sería la solución? (`bundle update` no parece el más indicado)
4. Corro `bundle install`
5. `bundle install` fracasa
6. Actualizo a mano usando `bundle update some_gem` aquellas gemas que fracasaron

### vii. `prueba_dos.rb`
> ¿Qué ocurrió al ejecutar `prueba_dos.rb` mediante las distintas formas enunciadas

Al ejecutarlo usando `ruby` lanzó una excepción ya que no conoce la constante `Bundler` (piensa que es una constante porque empieza con mayúscula según entiendo).

Al ejecutarlo usando `bundle exec ruby` funcionó, lo que sugiere que de alguna forma Bundler se *hace conocer* en el contexto de ruby que lanza.

Para que funcione correctamente de cualquier de las dos formas, debería agregar la sentencia `require "Bundler"` antes de utilizar `Bundler`.

**Duda**: al agregar `require "Bundler"` comenzó a funcionar al correr con `ruby prueba_dos.rb` pero escupe un *warning* al correrlo con `bundle exec prueba_dos.rb`.

1. ¿No hay que darle importancia?
2. ¿No se suele correr ruby en el contexto de Bundler con `bundle exec`?