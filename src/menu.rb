#Menus have a few properties
=begin
		Each menu 'screen' is composed of two elements: A textbox in the upperhalf, and an enumerated list of choices in the lower half.
		If the text is longer than the space provided, it can be scrolled using pgup/pgdn
		
		If the choice list is longer than 10 items, it can be scrolled using +/-
		Each menu can have an infinite number of screens. Menu options can link to screens or be canceled from screens using a stack
		
		#Building the menu
		#New creates a default, uninitialized menu with 1 screen, default text and a default choice.
		#Screens can be added by using addScreen, which will return a screenNo.
		#Choices can be added by using addChoice, which will return a choiceNo
		#Text can be added by using addText, which will replace the current text for that screen.
		
		#Screens read the following input: the number keys, the 'shift+number' symbols (! for 1, @ for 2, etc), and the ESC key, as well as pgdn/pgup/+/-
		
=end 

class Menu
	
	private
	
	class Screen #Holds n Choices and 1 Text
		attr_reader :id, :choices, :text, :currentScreen
		
		private
		
		class Element
			attr_reader :id
			attr_accessor :text, :colorID1, :colorID2 
			
			def initialize(id, text, colorID1, colorID2)
				@id = id 
				@text = text
				@colorID1 = colorID1
				@colorID2 = colorID2
			end 
		end
		
		def initialize( id )
			@id = id
			@choices = Hash.new
			@text = Element.new(nil, "", 0, 0)
		end
		
		public
		def removeChoice(id)
			@chocies[ id ] = nil
		end 
		
		def addChoice(id, str, colorID1, colorID2)
			@choices[ id ] = Element.new(id, str, colorID1, colorID2)
		end
		
		def setText(str, colorID1, colorID2)
			@text = Element.new(nil, str, colorID1, colorID2)
		end
		
		def to_s
			str = ""
			@choices.each_key do |i|
				str += "\t#{@choices[i].text}\n"
			end
			
			return "\t#{@text.text}\n#{ str }\n"		
		end
	end
	
	public 
	
	attr_reader :screens
	attr_accessor :currentScreen
	
	def addScreen( id )
		@screens[ id ] = Screen.new(id) if @screens[ id ] == nil
	end
	
	def removeScreen( screenID )
		if screenID != "SCREEN_DEFAULT"
			@screens[screenID] = nil
			@currentScreen = nil if @currentScreen == screenID
		end
	end
	
	def addChoice (screenID, choiceID, str, colorID1, colorID2)
		if @screens[ screenID ] != nil && @screens[ screenID ].choices[ choiceID ] == nil
			@screens[screenID].addChoice(choiceID, str, colorID1, colorID2) 
		end
	end
	
	def removeChoice(screenID, choiceID)
		if @screens[ screenID ] != nil && @screens[ screenID ].choices[ choiceID ] != nil
			@screens[screenID].removeChoice(choiceID) if screenID != "SCREEN_DEFAULT"
		end
	end 
	
	def setText (screenID, str, colorID1, colorID2)
		if @screens[screenID] != nil && screenID != "SCREEN_DEFAULT"
			@screens[screenID].setText(str, colorID1, colorID2)
		end
	end
	
	def initialize
		@screens = Hash.new
		addScreen("SCREEN_DEFAULT")
		addChoice("SCREEN_DEFAULT", "C_DEFAULT", "Default choice", 0, 0)
		setText("SCREEN_DEFAULT", "Default text", 0, 0)
		@currentScreen = "SCREEN_DEFAULT"
	end
end

class MenuLayout
	def to_s
		
		str = ""
		i = @menu.currentScreen
		
		if @menu.screens[i] == nil
			i = "SCREEN_DEFAULT"
		end
		
		str += "Screen: #{ @menu.screens[i].id }\n"	
		str += "\t#{@menu.screens[i].text.text}\n"
		
		@menu.screens[i].choices.each_key do |j|
			str += "\t#{@menu.screens[i].choices[j].text}\n"
		end	

		
		return str
	end

	def initialize( menu )
		@menu = menu
	end

end

class MenuController

	def addScreen( id )
		@menu.addScreen( id )
	end
	
	def removeScreen( id )
		@menu.removeScreen( id )
	end
	
	def addChoice (screenID, choiceID, str, colorID1, colorID2)
		@menu.addChoice( screenID, choiceID, str, colorID1, colorID2 )
	end
	
	def removeChoice(screenID, choiceID)
		@menu.removeChoice(screenID, choiceID)
	end 
	
	def setText (screenID, str, colorID1, colorID2)
		@menu.setText(screenID, str, colorID1, colorID2)
	end

	def initialize
		@menu = Menu.new
		@view = MenuLayout.new( @menu )
	end
	
	def currentScreen= (args) 
		@menu.currentScreen = args
	end
	
	def to_s
		return @view.to_s
	end
end

menu = MenuController.new

menu.addScreen( "SCREEN_CLASS" )
menu.setText( "SCREEN_CLASS", "Choose a class: ", 0, 0 )
menu.addChoice( "SCREEN_CLASS", "C_WAR", "Warrior", 0, 0)
menu.addChoice( "SCREEN_CLASS", "C_PRS", "Priest", 0, 0)
menu.addChoice( "SCREEN_CLASS", "C_PAL", "Paladin", 0, 0)

menu.addScreen( "SCREEN_RACE" )
menu.setText( "SCREEN_RACE", "Choose a race: ", 0, 0 )
menu.addChoice( "SCREEN_RACE", "C_HUM", "Human", 0, 0)
menu.addChoice( "SCREEN_RACE", "C_ELF", "Elf", 0, 0)
menu.addChoice( "SCREEN_RACE", "C_ORC", "Orc", 0, 0)

puts menu
menu.currentScreen = "SCREEN_RACE"
puts menu
menu.currentScreen = "SCREEN_CLASS"
puts menu
menu.currentScreen = "FAIL"
puts menu

