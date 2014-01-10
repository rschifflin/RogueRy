require 'singleton'
require 'engine/dispatcher'
require 'engine/models/wanderer'
require 'engine/views/ui_rect'

class Engine
  attr_reader :dispatcher, :interface_wrapper, :wanderer, :ui_tester, :ui_parent

  def initialize opts={}
    opts = defaults.merge opts
    @interface_wrapper = opts[:interface_wrapper]
    @dispatcher = Dispatcher.new
    @ui_parent = UIElement.new
    @rect1 = UIRect.new('.', 10, 10)
    @rect2 = UIRect.new('%', 15, 15)
    @rect3 = UIRect.new('#', 8, 8)

    @ui_parent.add_child(@rect1)
    @rect1.add_child(@rect2)
    @rect2.add_child(@rect3)
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
