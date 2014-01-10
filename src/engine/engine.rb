require 'singleton'
require 'engine/dispatcher'
require 'engine/views/ui_rect'
require 'engine/views/ui_dialog'

class Engine
  attr_reader :dispatcher, :interface_wrapper, :wanderer, :ui_tester, :ui_parent

  def initialize opts={}
    opts = defaults.merge opts
    @interface_wrapper = opts[:interface_wrapper]
    @dispatcher = Dispatcher.new
    @ui_parent = UIElement.new
    @ui_dialog = UIDialog.new.add_tag(:bg_light)
    @dialog_title = UIText.new("Title").add_tag(:title)
    @dialog_body = UIText.new("Body").add_tag(:body)
    @ui_dialog.add_child @dialog_title
    @ui_dialog.add_child @dialog_body
    @ui_parent.add_child @ui_dialog 
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
