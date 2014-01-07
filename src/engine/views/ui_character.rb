require "engine/views/ui_element"
class UICharacter < UIElement
  attr_reader :char
  def initialize char
    @w = 1
    @h = 1
    @char = char 
  end 

  def convert_using converter 
    converter.create_character_from self
  end
end
