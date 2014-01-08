require 'singleton'
require 'engine/dispatcher'
require 'engine/models/wanderer'

class Engine
  attr_reader :dispatcher, :interface_wrapper, :wanderer, :ui_tester, :ui_parent

  def initialize opts={}
    opts = defaults.merge opts
    @interface_wrapper = opts[:interface_wrapper]
    @dispatcher = Dispatcher.new
    @ui_parent = UIElement.new
    @char = UICharacter.new('.')
    @thingy = UICharacter.new('%')
    @wanderer = UICharacter.new('#')

    @ui_parent.add_child(@wanderer)
    @wanderer.add_child(@char)
    @char.add_child(@thingy)
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
