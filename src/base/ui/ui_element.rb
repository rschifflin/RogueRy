class UIElement
  attr_reader :x, :y, :h, :w, :parent, :children, :options
  def initialize(parent = nil) 
    @x, @y, @w, @h, @parent = 0,0,0,0, parent
    @children = []
    @parent.children << self if @parent 
    @options = {}
  end

  def move(x,y)
    @x = x
    @y = y
    self
  end

  def resize(w, h)
    @w = w
    @h = h
    self
  end

  def [] option
    @options[option]
  end

  def []= option, setting
    @options[option] = setting
  end

end
