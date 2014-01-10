require "engine/views/ui_element"
class UIRect < UIElement
  include Sizable

  attr_reader :char
  def initialize(char='#', width = 0, height = 0)
    @char = char
    self.resize(width, height)
  end

  def convert_using converter
    converter.create_rect_from self
  end
end
