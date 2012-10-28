require './vampire.rb'
class MyVampire < Vampire
	def initialize(name, vul=[:garlic, :sunlight], dangers=[:bites])
		super(true,2,name,vul,dangers)
	end
end
