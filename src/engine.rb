require 'singleton'
require 'curses'

class Engine
  include Singleton

  def initialize
  end

  def start io_wrapper
    stop if started?
    @io = io_wrapper
    @io.start
    enter_loop
    stop
  end

  def enter_loop
    while @input != ?q
      draw
      read_input
    end
  end

  def read_input
    @input = @io.input
  end

  def draw
    @io.output(@input || ??) if started?
  end

  def stop
    @io.stop if started?
  end

  def started?
    !!@io
  end

end
