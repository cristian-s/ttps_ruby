module Countable
	
	module ClassMethods

		def countable_initialize
			@@observed_methods ||= {}
			# self.send(:attr_accessor, :invocations_amounts)
		end
		
		def count_invocations_of sym
			@@observed_methods[sym] ||= 0
			alias_method "#{sym}_orig".to_sym, sym
			redefine_sym sym
		end

		def redefine_sym sym
			define_method sym do |*args|
				increase_amount_for sym
				self.send "#{sym}_orig".to_sym, *args
			end
		end

		def under_observation? sym
			@@observed_methods[sym] || false
		end
	end

	def self.included base
		base.extend(ClassMethods)
		base.countable_initialize
	end
	
	def invoked? sym
		initialize_sym_if_should sym
		@invocations_amounts[sym] != 0
	end

	def invoked sym
		initialize_sym_if_should sym
		@invocations_amounts[sym]
	end

	def initialize_sym_if_should sym
		@invocations_amounts ||= {}
		if @invocations_amounts[sym].nil?
			raise "Método no observado" unless self.class.under_observation? sym
			@invocations_amounts[sym] = 0
		end
	end

	def increase_amount_for sym
		@invocations_amounts ||= {}
		@invocations_amounts[sym] = 0 unless @invocations_amounts[sym]
		@invocations_amounts[sym] += 1
	end
end