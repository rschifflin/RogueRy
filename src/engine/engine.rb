require 'singleton'
require 'engine/dispatcher'
require 'engine/models/wanderer'
require 'engine/models/ui_tester'

class Engine
  include Singleton
  attr_reader :dispatcher, :renderer, :wanderer, :ui_tester

  def initialize
    @dispatcher = Dispatcher.new
    @ui_tester = UITester.new
    @wanderer = Wanderer.new(11,4)
    dispatcher.subscribe(wanderer, :left, :left)
    dispatcher.subscribe(wanderer, :right, :right)
    dispatcher.subscribe(wanderer, :up, :up)
    dispatcher.subscribe(wanderer, :down, :down)
  end

  def add_renderer renderer
    @renderer = renderer
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

    renderer.clear
    renderer.update(ui_tester.view)
    renderer.render
  end

end
