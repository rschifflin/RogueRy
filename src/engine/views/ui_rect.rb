require "engine/views/ui_element"
class UIRect < UIElement
  attr_reader :char
  def initialize char='#'
    @char = char
  end

  def convert_using converter
    converter.create_rect_from self
  end
end
