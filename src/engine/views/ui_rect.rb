require "engine/views/ui_element"
class UIRect < UIElement
  attr_reader :char
  def initialize char='#'
    @char = char
  end
end
