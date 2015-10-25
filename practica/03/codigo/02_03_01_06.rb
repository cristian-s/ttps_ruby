require 'minitest/autorun'
require 'minitest/spec'

def contar_palabras universe, target
	universe.scan(/\b#{target}\b/i).size
end

describe "#contar_palabras" do

	it "el segundo string se encuentra en el primero en forma de palabra, una vez" do
		assert_equal(1, contar_palabras("hola como andas", "como"))
	end

	it "el segundo string se encuentra una vez en el primero, pero no como una palabra" do
		assert_equal(0, contar_palabras("calcio", "cal"))
	end

	it "el segundo string se encuentra en el primero en forma de palabra, tres veces" do
		assert_equal(3, contar_palabras("hola hola hola como te va", "hola"))
	end

end