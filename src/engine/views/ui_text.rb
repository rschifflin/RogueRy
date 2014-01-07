require "engine/views/ui_element"
class UIText < UIElement
  attr_reader :text
  def initialize(string="")
    @text = string 
    self[:overflow] = :hidden 
  end 

  def text= string
    @text = string.to_s
  end

  def convert_using converter
    converter.create_text_from self
  end
end
