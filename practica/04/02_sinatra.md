# Sinatra
## 1. Investigar
### ¿Qué es **Rack**?
**Rack** es una gema que permite comunicar *web servers* con *web applications*. Una mecánica de comunicación simple es más o menos así:

```
 ________         ________         _______ 
|        |       |        |       |       |
|  Web   |  ==>  |  Rack  |  ==>  |  App  |
| Server |       |        |       |       |
|________|       |________|       |_______|
```

* El **Web Server** recibe las peticiones de Internet y las envía a **Rack**.
* **Rack** procesa la petición acorde a cierta lógica encerrada en su archivo de configuración y la envía a una **Application**.
* La **Application** consiste en una clase ruby que entiende el mensaje `#call(env)` (`env` es un hash con el *environment*) y a partir del cual realiza el procesamiento correspondiente a la aplicación. Luego retorna una *response*, que consiste en un array con un *http status*, un hash de *http headers* y un array que corresponde al *body*.

La forma de conectar el **Web Server** con la **Application** es mediante el archivo `config.ru`, en el que a través de una *DSL* se especifica la lógica con la que **Rack** tratará las peticiones recibidas. Ejemplo:

> JSONServer es una webapp que retorna un JSON. Mediante el comando `run` se le envía el mensaje `#call(env)` con el respectivo argumento.

```ruby
class JSONServer
	def call(env)
		[ 200, {"Content-Type" => "applications/json"}, [%({ "message" : "Hello!"})]]
	end
end
```

```ruby
require "JSONServer"

map "/hello.json" do
	run JSONServer.new
end
```

Rack permite encadenar apps, quedando un flujo así:

```
 ________         ________         _________                   _________         _______ 
|        |       |        |       |         |                 |         |       |       |
|  Web   |  ==>  |  Rack  |  ==>  | Middle- |  ==>  ...  ==>  | Middle- |  ==>  |  App  |
| Server |       |        |       |   ware  |                 |   ware  |       |       |
|________|       |________|       |_________|                 |_________|       |_______|
```

Los *middlewares* son simplemente apps que definen un método `#initialize(app)` en el que se setea la variable de instancia `@app` con el arg `app`, que consiste en la siguiente app de la cadena. También, como todas las apps, definen el método `#call(env)`, pero, a diferencia de las apps primeramente descriptas, deben ocuparse de invocar a la siguiente en la cadena, y es por eso que la reciben. Ejemplo:

> `RackBenchmark` es una clase que loggea el tiempo que llevó atender la petición.

```ruby
class RackLogger
	def initialize(app)
		@app = app
	end
	
	def call(env)
		@start = Time.now
		@status, @headers, @body = @app.call(env)
		@duration = ((Time.now - @start).to_f * 1000).round(2)
		
		puts "#{env["REQUEST_METHOD"]} #{env["REQUEST_PATH"]} - Took: #{@duration} ms
		[@status, @headers, @body]
	end
end
```

```ruby
require "JSONServer"

use RackLogger

map "/hello.json" do
	run JSONServer.new
end
```

La directiva `use some_class` se encarga de tratar a `some_class` como si fuera un *middleware*, inicializándolo con `app` e invocándolo con `#call(env)`. En este caso, se especifica `RackBenchmark` como primer *middleware*. En la cadena de apps, a él le llega en `app` nuestra aplicación final `JSONServer`. Al servir una petición, se invocan todos los middlewares en el orden en el que fueron agregados mediante `use`.

**Duda 1**: supongo que hay ciertos middlewares default que son invocados antes que los del usuario. ¿Es correcto? ¿Se puede hacer que se invoquen primero los middleware propios?

**Duda 2**: ¿por qué en los ejemplos las variables `status, headers, body` son de instancia y no locales?

##### Fuentes
* [chneukirchen.org](http://chneukirchen.org/blog/archive/2007/02/introducing-rack.html)
* [southdesign.de](http://southdesign.de/blog/rack.html)
* [guides.rubyonrails.org](http://guides.rubyonrails.org/rails_on_rack.html#resources)

## 2. Implementar
> Una app Rack llamada "MoL" que responda con un número al azar entre 1 y 42, devolviendo un status 200 si este es 42, caso contrario un 404.

[Código](./02_02/)

## 3. Responder
> Sinatra se define como "DSL para crear aplicaciones web". ¿Qué quiere decir esto? ¿Qué es DSL?

DSL es un acrónico de *Domain Specific Language*. El hecho de que se autodefinan como una herramienta tal debe significar que proveen una forma simple, concisa y efectiva de programar aplicaciones web mediante directivas especiales.

### Ruteo
Las directivas principales son las de ruteo.

* `get "/some_path"`
* `post "/some_path"`
* `put "/some_path"`
* `patch "/some_path"`
* `delete "/some_path"`
* `options "/some_path"`
* `link "/some_path"`
* `unlink "/some_path"`

Todas reciben un bloque que puede recibir parámetros. Los parámetros pueden definirse en `some_path` mediante `:param`, por ejemplo: `clients/:client_id`. Dentro del bloque, se conoce un *hash* `params`, al cual le podremos consultar por `params["client_id"]`. También podríamos enviar los parámetros al bloque directamente:

```ruby
get "/clients/:client_id" do |c_id|
	"Param: #{c_id}"
end
```

Se pueden usar splats:

```ruby
get "/client/*/order/*" do
	# /client/1/order/10
	params["splat"] # => ["1", "10"]
end
```

```ruby
get "/client/*/order/*" do |c_id, o_id|
	# /client/1/order/10
	[c_id, o_id] # => ["1", "10"]
end
```

Expresiones regulares, parámetros opcionales, y los parámetros pelados del método GET.

Las rutas admiten condiciones. Las condiciones se expresan como si fueran un par clave valor: la condición se identifica mediante un símbolo, y el valor será evaluado acorde a cierta lógica asociada a la condición. Por ejemplo:

```ruby
set(:is_five) do |number|
	condition do
		number == 5
	end
end

get "/", :is_five => 5 do
	"It was five!"
end

get "/", :is_five => 4 do
	"You really shouldn't be here"
end
```

Estas condiciones pueden admitir splats:

```
set(:auth) do |*roles|   # <- notice the splat here
  condition do
    unless logged_in? && roles.any? {|role| current_user.in_role? role }
      redirect "/login/", 303
    end
  end
end

get "/my/account/", :auth => [:user, :admin] do
  "Your Account Details"
end

get "/only/admin/", :auth => :admin do
  "Only admins are allowed here!"
end
```

##### Valores de retorno
Un bloque asociado a una ruta puede retornar:

* un array a lo Rack
* un array con status y body
* un objeto que responde a `#each` y escupe strings
* un status (número)

### Template engines
Son herramientas que proveen una DSL que permite construir vistas dinámicas de forma simple y reutilizando código.

##### Render method
Los *template engines* exponen un método que retorna un string. Por ejemplo, `erb` recibe un símbolo que identifica un template, renderiza la vista y retorna el string correspondiente. 

##### Options
El método de renderizado admite argumentos en forma de doble splat. Algunos son: `locals`, que recibe un hash de variables que luego serán conocidas en el template, `content_type`, `default_encoding`.

Ejemplo:

```
get "/" do
	erb :index
end

get "/clients" do
	some_erb_code = "Hello <%= name %>"
	erb some_erb_code, :locals => { name: "Cristian" }
end
```

## 4. Implementar
> La app MoL del punto 2, ahora usando Sinatra.

[Código](./02_04/)

## 5. Implementar
> Utilizando Sinatra, una aplicación web que tenga los siguientes endpoints:>> * GET / lista todos los endpoints disponibles (sirve a modo de documentación)> * GET /mcm/:a/:b calcula y presenta el mínimo común múltiplo de los valores numéricos :a y :b> * GET /mcd/:a/:b calcula y presenta el máximo común divisor de los valores numéricos :a y :b> * GET /sum/* calcula la sumatoria de todos los valores numéricos recibidos como parámetro en el splat
> * GET /even/* presenta la cantidad de números pares que hay entre los valores numéricos recibidos comoparámetro en el splat> * POST /random presenta un número al azar> * POST /random/:lower/:upper presenta un número al azar entre :lower y :upper (dos valores numéricos)

[Código](./02_05)

## 6. Implementar
> Un middleware para Sinatra que modifique la respuesta del web server y "tache" cualquier número que aparezca en el body de la respuesta, cambiando cada dígito por un caracter X . Utilizalo en la aplicación anterior para corroborar su funcionamiento.

[Código](./extras/middlewares/FuckThoseNumbers.rb)

## 7. Implementar
> Un middleware para Sinatra que agregue una cabecera a la respuesta HTTP, llamada X-Xs-Count, cuyo valor sea la cantidad de caracteres X que encuentra en el body de la respuesta. ¿Cómo debés incluirlo en tu app Sinatra para que este middleware se ejecute antes que el desarrollado en el punto anterior?

[Código](./extras/middlewares/x_counter.rb)

## 8. Implementar
> Una app sinatra para jugar al ahorcado. Internamente debe manejar una lista de palabras con un cierto identificador, cada una representando una partida que puede ser jugada una sóla vez por ejecución del servidor de la web app.
> 
> Se deben proveer las siguientes URLs:
> 
> * `POST /`: inicia una partida. Internamente, toma una palabra al azar de entre las de la lista y redirige a la URL correspondiente a la partida (se utiliza el identificador de la palabra).
> * `GET /partida/:id`: muestra el estado actual de la partida: letras adivinadas, intentos fallidos y cantidad de intentos restantes. Si se adivinó la palabra o se acabaron los intentos también debe ser reflejado.
> * `PUT /partida/:id`: recibe por PUT un parámetro `intento` con la letra del intento actual. Internamente, se actualiza el estado de la partida y se redirige al estado de la partida.

### Análisis

##### Vistas
Arranco por las vistas y el flujo. Tendré las vistas:

* Home
	* Link a `POST /`
	* Listado de partidas en curso
	* Listado de partidas finalizadas
* Partida
	* Representación de palabra
	* Cantidad de intentos fallidos
	* Cantidad de intentos restantes
	* ASCII hangman

##### Gestión de las partidas
Dispondremos de una clase `Game` que se instanciará con una palabra y permitirá:

* obtener la palabra
* obtener la palabra con los caracteres adivinados
* realizar un *intento* con una letra; 
* consultar los intentos restantes;