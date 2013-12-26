require File.dirname(__FILE__) + '/config/boot.rb'

#Load our engine
require 'engine/engine'

#Load our interface
require 'interface/curses/controller/curses_controller'
require 'interface/curses/renderer/curses_renderer'

#Load our dependencies - Curses
require 'wrappers/curses_io_wrapper'

#For curses
io_wrapper = CursesIOWrapper.new
controller = CursesController.new
renderer = CursesRenderer.new

#Set up controller
controller.add_renderer renderer
controller.add_engine Engine.instance
controller.add_io_wrapper io_wrapper

#Set up renderer
renderer.add_io_wrapper io_wrapper

#Set up engine
Engine.instance.add_renderer renderer

io_wrapper.run do
  while true
    input = io_wrapper.input
    break if input == ?q
    controller.input input
  end
end
