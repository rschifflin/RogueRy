require 'singleton'
require 'curses'

class Engine
  include Singleton

  def initialize
    @started = false
    @wanderer = Wanderer.new(11,4);
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
    case component[:input].input
    when ?q then @input = :quit
    when ?a then @input = :left
    when ?d then @input = :right
    when ?w then @input = :up
    when ?s then @input = :down
    end
  end

  def update
    case @input
    when :left then @wanderer.left()
    when :right then @wanderer.right()
    when :up then @wanderer.up()
    when :down then @wanderer.down()
    end
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
