class UIElement
  attr_reader :x, :y, :h, :w, :parent, :children, :options
  def initialize(parent = nil) 
    @x, @y, @w, @h, @parent = 0,0,0,0, parent
    @children = []
    @parent.children << self if @parent 
  end

  def config options
    @options.each_key { |k| @options[k] = options[k] if options[k] }
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

end
