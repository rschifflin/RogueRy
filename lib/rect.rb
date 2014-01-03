class Rect
  attr_reader :x, :y, :w, :h
  def initialize(opts = {})
    properties = defaults.merge(opts)
    @x = properties[:x]
    @y = properties[:y]
    @w = properties[:w]
    @h = properties[:h]
  end

  def move(xnew, ynew)
    self.x = xnew
    self.y = ynew
    self
  end

  def resize(wnew, hnew)
    self.w = wnew
    self.h = hnew
    self
  end

  def coords
    [x,y]
  end
  alias :coordinates :coords

  def dimensions
    [w,h]
  end

  def properties
    [x, y, w, h]
  end

  def x= position
    position < 0 ? @x = 0 : @x = position
  end
  def y= position
    position < 0 ? @y = 0 : @y = position
  end
  def w= length
    length < 0 ? @w = 0 : @w = length
  end
  def h= length
    length < 0 ? @h = 0 : @h = length
  end

  def self.intersection_of_rects rect, container
    #Determine the top left coord
    x1 = [rect.x, container.x].max
    y1 = [rect.y, container.y].max
    x2 = [rect.x + rect.w, container.x + container.w].min
    y2 = [rect.y + rect.h, container.y + container.h].min
    if 
      x1 >= container.x + container.w || 
      y1 >= container.y + container.h || 
      x2 < container.x ||
      y2 < container.y
        return Rect.new(x: 0, y: 0, w: 0, h: 0)
    end

    Rect.new(x: x1, y: y1, w: x2 - x1, h: y2 - y1)
  end

  def self.offset_of_rects offset, base
    Rect.new(x: base.x + offset.x, 
             y: base.y + offset.y,
             w: offset.w,
             h: offset.h)
  end

  def defaults
    {x: 0, y: 0, w: 0, h: 0}
  end
end
