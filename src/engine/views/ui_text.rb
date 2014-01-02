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
end
