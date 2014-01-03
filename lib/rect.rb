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

  def rect_within container
    #Determine the top left coord
    x1 = [self.x, container.x].max
    y1 = [self.y, container.y].max
    x2 = [self.x + self.w, container.x + container.w].min
    y2 = [self.y + self.h, container.y + container.h].min
    if 
      x1 >= container.x + container.w || 
      y1 >= container.y + container.h || 
      x2 < container.x ||
      y2 < container.y
        return Rect.new(x: 0, y: 0, w: 0, h: 0)
    end

    Rect.new(x: x1, y: y1, w: x2 - x1, h: y2 - y1)
    #Return a rect such that only the overlapping area of the original rect within the container remains
  end

  def rect_offset_from rect
    Rect.new(x: rect.x + self.x, 
             y: rect.y + self.y,
             w: self.w,
             h: self.h)
  end

  def defaults
    {x: 0, y: 0, w: 0, h: 0}
  end
end
