class UIText < UIElement
  attr_reader :text
  def initialize(parent=nil, string="")
    super(parent)
    @text = string 
    self[:overflow] = :hidden 
  end 

  def text= string
    @text = string.to_s
  end
end
