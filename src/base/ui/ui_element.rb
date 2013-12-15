class UIElement
  attr_reader :x, :y, :h, :w, :parent, :childen, :options
  def initialize *args, &block
    @x, @y, @w, @h, @parent = 0,0,0,0,nil
    @x, @y, @w, @h, @parent = *args

    @children = []
    @parent.children << self if @parent 
  end

  def config options
    @options.each_key { |k| @options[k] = options[k] if options[k] }
  end

  def move(x,y)
    @x = x
    @y = y
  end
end
