require 'minitest/autorun'
require 'minitest/spec'

def contar (universe, target)
	universe.scan(/#{target}/i).size
end

describe "#contar" do

	describe "los strings no tienen espacios" do

		it "el segundo string está contenido una vez en el primero" do
			assert_equal(1, contar("palabra", "abra"))
		end

		it "el segundo string está contenido tres veces en el primero" do
			assert_equal(3, contar("paralelogramo", "a"))
		end

		it "el segundo string no está contenido en el primero" do
			assert_equal(0, contar("palabra", "hola"))
		end

		it "el segundo string es más largo" do
			assert_equal(0, contar("palabra", "Argentina"))
		end

	end

	describe "los strings tienen espacios" do

		it "el segundo string está contenido en el primero" do
			assert_equal(1, contar("hola como te va", "omo te "))
		end

		it "el segundo string está contenido tres veces en el primero" do
			assert_equal(3, contar("asdar asdar asdar asdar", "ar as"))
		end

		it "el segundo string no está contenido en el primero" do
			assert_equal(0, contar("hola como te va", "como andas"))
		end

		it "el segundo string es más largo" do
			assert_equal(0, contar("hola como te va", "hola, todo bien y a vos?"))
		end

	end

end