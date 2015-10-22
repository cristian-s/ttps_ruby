module Countable
	# attr_accessor :__countable_invocations_amounts
	
	class CountableMixinError < Exception
	end

	@__countable_invocations_amounts = {}

	def count_invocations_of symbol
		@__countable_invocations_amounts ||= {}
		@__countable_invocations_amounts[symbol] = 0

		symbol_orig = "#{symbol.to_s}_orig".to_sym
		self.class.send(:alias_method, symbol_orig, symbol)
		
		self.class.send(:define_method, symbol) do
			@__countable_invocations_amounts[symbol] += 1
			self.send(symbol_orig)
		end
	end

	def invoked? symbol
		result = @__countable_invocations_amounts[symbol]
		check_invocations_error result
		result != 0
	end

	def invoked symbol
		result = @__countable_invocations_amounts[symbol]
		check_invocations_error result
		result
	end

	def check_invocations_error result
		raise(CountableMixinError, 
			"No se está monitoreando el método. Se sugiere agregarlo a los métodos
			monitoreados mediante Countable#count_invocations_of") if result.nil?
	end
end