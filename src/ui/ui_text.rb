class UIText < UIElement
  attr_reader :text
  def initialize(parent=nil, string="")
    super(parent)
    @text = string 
    @options = { :overflow => :hide }
  end 
  def text= string
    @text = string.to_s
  end

end
