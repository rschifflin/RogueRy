class UIText < UIElement
  attr_reader :text
  def initialize x=0, y=0, w=0, h=0, parent=nil, string=""
    super
    @text = string 
    @options = { overflow: :hide }
  end 

end
