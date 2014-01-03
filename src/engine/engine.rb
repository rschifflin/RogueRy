require 'singleton'
require 'engine/dispatcher'
require 'engine/models/wanderer'
require 'engine/models/debug_text'
require 'engine/models/debug_rect'

class Engine
  attr_reader :dispatcher, :interface_wrapper, :wanderer, :ui_tester

  def initialize opts={}
    opts = defaults.merge opts
    @interface_wrapper = opts[:interface_wrapper]
    @dispatcher = Dispatcher.new
    @ui_parent = UIElement.new.move(0,0).resize(100,100)

    @text1 = DebugText.new(18,20,40,20,"This is some text")
    @text2 = DebugText.new(12,12,40,10,"This is even more text")
    @rect1 = DebugRect.new(3,3,10,10,'.')
    @rect2 = DebugRect.new(1,1,5,5,'#')
    @wanderer = Wanderer.new(11,4)

    @ui_parent.add_child(@text1.view)
    @ui_parent.add_child(@text2.view)
    @ui_parent.add_child(@rect1.view)
    @ui_parent.add_child(@wanderer.view)
    @rect1.view.add_child(@rect2.view)

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

    interface_wrapper.update(@ui_parent)
  end

end
