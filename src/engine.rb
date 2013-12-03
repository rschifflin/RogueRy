require 'singleton'
require 'curses'

class Engine
  include Singleton
  attr_reader :dispatcher

  def initialize
    @started = false
    @dispatcher = Dispatcher.new

    @wanderer = Wanderer.new(11,4)
    dispatcher.subscribe(@wanderer, :left, :left)
    dispatcher.subscribe(@wanderer, :right, :right)
    dispatcher.subscribe(@wanderer, :up, :up)
    dispatcher.subscribe(@wanderer, :down, :down)
  end

  def configure hash
    hash.each { |key, value| component[key] = value.new }
  end

  def start 
    stop if started?
    @started = true
    start_components
    enter_loop
    stop
  end

  def enter_loop
    while @input != :quit
      read_input
      update
      draw
    end
  end

  def read_input
    @input = component[:input].input
  end

  def update
    dispatcher.dispatch(@input)
    @response = @wanderer.pos
  end

  def draw
    component[:draw].output(@response)
  end

  def stop
    if started?
      stop_components
      @started = false
    end
  end

  def started?
    @started
  end

  def component
    @component ||= {}
  end

private
  def start_components
    component[:input].start
    component[:draw].start
  end

  def stop_components
    component[:input].stop
    component[:draw].stop
  end

end
