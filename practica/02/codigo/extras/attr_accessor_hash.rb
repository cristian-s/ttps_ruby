class AttrAccessorHash
	attr_accessor :hash
	def initialize
		@hash = {}
	end
end

aah = AttrAccessorHash.new
aah.hash[:shit] = 0
puts aah.hash[:shit]