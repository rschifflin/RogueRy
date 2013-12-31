require 'singleton'
require 'engine/dispatcher'
require 'engine/models/wanderer'
require 'engine/models/ui_tester'

class Engine
  attr_reader :dispatcher, :interface_wrapper, :wanderer, :ui_tester

  def initialize opts={}
    opts = defaults.merge opts
    @interface_wrapper = opts[:interface_wrapper]
    @dispatcher = Dispatcher.new
    @ui_tester = UITester.new
    @wanderer = Wanderer.new(11,4)
    dispatcher.subscribe(wanderer, :left, :left)
    dispatcher.subscribe(wanderer, :right, :right)
    dispatcher.subscribe(wanderer, :up, :up)
    dispatcher.subscribe(wanderer, :down, :down)
  end

  def defaults
    {}
  end

  def handle input
    case input
    when ?w
      dispatcher.dispatch(:up)
    when ?a
      dispatcher.dispatch(:left)
    when ?s
      dispatcher.dispatch(:down)
    when ?d
      dispatcher.dispatch(:right)
    end

    interface_wrapper.update(wanderer.view)
  end

end
