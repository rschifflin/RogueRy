require File.dirname(__FILE__) + '/config/boot.rb'

require 'engine/engine'
require 'client/curses/curses_controller'
require 'client/curses/curses_converter'
require 'client/curses/curses_formatter'
require 'client/curses/curses_syncer'
require 'client/curses/curses_renderer'
require 'client/curses/curses_view_keeper'
require 'client/curses/curses_io_wrapper'
require 'client/curses/curses_interface_wrapper'

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

def converter
  @converter ||= CursesConverter.new
end

def formatter
  @formatter ||= CursesFormatter.new
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
interface_wrapper.configure(converter: converter, formatter: formatter, syncer: syncer, renderer: renderer, engine: engine)
io_wrapper.configure(controller: controller)

io_wrapper.run do
  while true
    input = io_wrapper.input
    break if input == false
  end
end
