require File.dirname(__FILE__) + '/config/boot.rb'

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
