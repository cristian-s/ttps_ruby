module Oppositable
	def opposite
		!self
	end
end

class TrueClass
	include Oppositable
end

class FalseClass
	include Oppositable
end