##Engine States
=begin
	Uninit: 	Initial state
	NewChar: 	Making a new character
	Tick Loop: 	The main 'game loop'
	Action:		The main 'game loop'
	Help:		A help dialog is shown
	Aim:		Targetting mode
	Inventory: 	Inventory mode
	Examine: 	Examine mode
	Dead:		Post-game score screen
=end

module Keys
	NUMPAD_7 = 449
	NUMPAD_8 = 450
	NUMPAD_9 = 451
	NUMPAD_4 = 452
	NUMPAD_5 = 453
	NUMPAD_6 = 454
	NUMPAD_1 = 455
	NUMPAD_2 = 456
	NUMPAD_3 = 457

	F1 = 265
	F2 = 266
	F3 = 267
	F4 = 268

	F5 = 269
	F6 = 270
	F7 = 271
	F8 = 272

	F9 = 273
	F10 = 274
	F11 = 275
	F12 = 276
	
	ESC = 27
end

module State
	UNINIT		= 1
	NEWCHAR		= 2
	TICKLOOP	= 3
	ACTION		= 4
	HELP		= 5
	AIM			= 6
	INVENTORY	= 7
	EXAMINE		= 8
	DEAD		= 9
end

require 'curses'
require_relative 'game_object'
require_relative 'level'

include Curses

class Engine
	attr_reader 	:screen, :state
	attr_accessor 	:isRunning
	
	##Public Methods
	def waitForInput( obj )
		#Handles input
		nextch = getch

		case @state
			when State::ACTION then
			#The object stored in @actionObj is waiting on input.
			#We first try to handle engine input ie Help screens, TARGETTING mode, EXAMINE mode, etc
			#If no input matches, we ask the object for its possible inputs
			#If no input matches, we discard the input
			#If any input matches, we perform the appropriate actions then advance to the appropriate state
				case nextch
					when Keys::F1..Keys::F12 then #Function keys: Display help dialog, transition to Help state
						@state = State::HELP
					
					when Keys::NUMPAD_7..Keys::NUMPAD_3 then #Direction: should toss to object; for now ghetto move
						case nextch
							when Keys::NUMPAD_1..Keys::NUMPAD_3 then 
								if (obj.ypos < (lines - 2) )
									obj.ypos += 1
								end
							when Keys::NUMPAD_7..Keys::NUMPAD_9 then 
								if (obj.ypos > 1)
									obj.ypos -= 1
								end
						end 
						case nextch
							when Keys::NUMPAD_3, Keys::NUMPAD_6, Keys::NUMPAD_9 then 
								if (obj.xpos < (cols - 2) )
									obj.xpos += 1
								end
							when Keys::NUMPAD_1, Keys::NUMPAD_4, Keys::NUMPAD_7 then
								if (obj.xpos > 1)
									obj.xpos -= 1
								end
						end
						@actionObj.tickCounter += 30 #Movement speed = 1meter/30ticks = 0.333 meters/tick
						@state = State::TICKLOOP
						
					when ?q then @state = State::UNINIT #Quit
				end
			
			when State::NEWCHAR then
				case nextch
					when '1'..'9' then @state = State::TICKLOOP
				end
				
			when State::HELP then 
				case nextch
					when '1'..'9' then #Help is a free action
						
					
					when Keys::ESC then @state = State::ACTION
				end			
		end
	end
	
	def createObject( objectType, xPos, yPos )
		#Makes a new GameObject and adds it to @objects
		
		#return object.id
	end 
	
	def destroyObject ( objID )
		#Removes the game object from the @objects and levels list
		
	end
	
	def changelevel( levelNo )
		#Changes the current level. If @levels[ levelNo ] == nil, autogenerates a new floor
		
	end
	
	def showCharDialog
		clear()
		setpos(2,2)
		addstr("Choose your character")
		setpos(3,2)
		attron(color_pair(1)) { addstr("1.\tWarrior") }
		@screen.box('%','%')
		refresh
		
		waitForInput( nil )
	end
	
	def showHelpDialog
		clear
		setpos(2,2)
		addstr("This is the help dialog. Press the number of the topic you'd like")
		setpos(3,2)
		attron(color_pair(1)) { addstr("1.\tGame Mechanics") }
		setpos(4,2)
		attron(color_pair(2)) { addstr("2.\tClasses") }
		setpos(5,2)
		attron(color_pair(3)) { addstr("3.\tGetting Started") }
		@screen.box('?','?')
		refresh
		
		waitForInput( nil )
	end
	
	def update
		case @state
			when State::TICKLOOP then
				tick
			when State::NEWCHAR then
				showCharDialog
			when State::ACTION then
				clear
				draw
				refresh 
				
				if @actionObj.is_a? TestPlayerObject
					waitForInput( @actionObj )
				else
					@actionObj.action
					@state = State::TICKLOOP
				end
				
			when State::HELP then
				showHelpDialog
		end
	end
	
	def tick
		if (@objects.size > 0)
		
			if (@tickIndex >= @objects.size)
				@tickIndex = 0
			end
			
			@objects[ @tickIndex ].tick
			if (@objects[ @tickIndex ].tickCounter <= 0)
				@actionObj = @objects[ @tickIndex ]
				@state = State::ACTION
			end
			
			@tickIndex += 1
		end

		
	end
	
	def start
		@state = State::NEWCHAR
		
		while @state != State::UNINIT do
			update
		end

		#Unload curses
		clear
		refresh
		
		noraw
		curs_set 1
		echo
		
		close_screen
		
	end
	
	##Private Methods
	
	def initialize
		#Member init
		@objects = Array.new
		@levels = Array.new
		@currentLevel = 1
		
		@objects[0] = TestPlayerObject.new(self)
		@objects[1] = GameObject.new(self)
		
		@state = State::UNINIT
		@actionObj = nil
		@tickIndex = 0
		
		##Curses Init
		@screen = init_screen #Create our default Curses console-wide screen and initialize Curses
		raw					#uncook input
		@screen.keypad true 	#Enables extra key support
		start_color			#Enables color console input
		curs_set 0			#Make the cursor invisible
		noecho				#Don't echo our keystrokes back at us
		##COLORS
		init_pair(3, COLOR_GREEN, COLOR_WHITE)
		init_pair(1, COLOR_WHITE, COLOR_BLUE)
		init_pair(2, COLOR_YELLOW, COLOR_BLACK)
	end
	
	def draw
		
		lines.times do |i|
			setpos(i, 0)
			cols.times { addch(',') }
		end
		
		attron(color_pair(2)) { @screen.box('#','#') }
		
		@objects.size.times do |i|
			@objects[i].draw
		end
		
		##Refresh the console		
		refresh	
	end
	
end