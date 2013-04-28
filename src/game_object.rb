class GameObject
	@@idCounter = 1

	attr_reader  
	attr_accessor :tickCounter, :ypos, :xpos
	
	def action
		@tickCounter += 5
		@xpos += 1
		@ypos += 1
	end
	
	def initialize (engine)
		@engine = engine
		@tickCounter = 0
		@id = @@idCounter
		@@idCounter += 1
		
		@symbol = ?%
		@ypos = 0
		@xpos = 0
	end 
	
	def draw
		@engine.screen.setpos(@ypos, @xpos)
		@engine.screen.addch(@symbol)
	end
	
	def tick
		if (@tickCounter > 0)
			@tickCounter -= 1
		end
	end

end

class TestPlayerObject < GameObject
	def initialize (engine)
		super( engine )
		@symbol = ?@
	end
end