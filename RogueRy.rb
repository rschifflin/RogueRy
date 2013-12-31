require File.dirname(__FILE__) + '/config/boot.rb'

require 'engine/engine'
require 'interface/curses/controller/curses_controller'
require 'interface/curses/curses_syncer'
require 'interface/curses/renderer/curses_renderer'
require 'interface/curses/curses_view_keeper'
require 'wrappers/curses_io_wrapper'
require 'wrappers/curses_interface_wrapper'

#Create our boundary wrappers
def io_wrapper
  @io_wrapper ||= CursesIOWrapper.new
end

def interface_wrapper
  @interface_wrapper ||= CursesInterfaceWrapper.new
end

#Inject the components
def engine
  @engine ||= Engine.new(interface_wrapper: interface_wrapper)
end

def view_keeper
  @view_keeper ||= CursesViewKeeper.new
end

def syncer
  @syncer ||= CursesSyncer.new(view_keeper: view_keeper)
end

def renderer
  @renderer ||= CursesRenderer.new(view_keeper: view_keeper, io_wrapper: io_wrapper)
end

def controller
  @controller ||= CursesController.new(view_keeper: view_keeper, renderer: renderer, interface_wrapper: interface_wrapper)
end

#Wire up the boundaries
interface_wrapper.configure(syncer: syncer, renderer: renderer, engine: engine)
io_wrapper.configure(controller: controller)

io_wrapper.run do
  while true
    input = io_wrapper.input
    break if input == false
  end
end
