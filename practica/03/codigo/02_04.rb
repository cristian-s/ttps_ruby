require "minitest/autorun"
require "minitest/spec"

require_relative "../../02/codigo/02_04_Countable"
require_relative "../../02/codigo/02_04_Platense"

def test_on(klass, syms)
	klass.instance_eval { include Countable }
	instance = klass.new
	klass.count_invocations_of(syms[1])
	klass.count_invocations_of(syms[2])
	klass.count_invocations_of(syms[3])
	instance.send(syms[2])
	instance.send(syms[3])
	instance.send(syms[3])
	instance.send(syms[3])
	
	it "class understands `count_invocations_of`" do
		assert_respond_to(klass, :count_invocations_of)
	end
	
	it "instances understand `invoked` and `invoked?`" do
		assert_respond_to(instance, :invoked)
		assert_respond_to(instance, :invoked?)
	end

	it "`invoked?` on a non observed method" do
		assert_raises(RuntimeError) do
			instance.invoked?(syms[0])
		end
	end

	it "`invoked` on a non observed method" do
		assert_raises(RuntimeError) do
			instance.invoked(syms[0])
		end
	end

	
	it "`invoked?` on an observed method that hasn't been called yet" do
		refute(instance.invoked?(syms[1]))
	end
	
	it "`invoked` on an observed method that hasn't been called yet" do
		assert_equal(0, instance.invoked(syms[1]))
	end


	it "`invoked?` on an observed method that has already been called" do
		assert(instance.invoked?(syms[2]))
	end

	it "`invoked` on an observed method that has been called 1 time" do
		assert_equal(1, instance.invoked(syms[2]))
	end


	it "`invoked` on an observed method that has been called 3 times" do
		assert_equal(3, instance.invoked(syms[3]))
	end
end

describe Countable do
	describe Array do
		test_on(Array, [:to_s, :lazy, :object_id, :nil?])
	end

	describe Platense do
		test_on(Platense, [:say_city, :say_state, :say_country, :nil?])
	end
end