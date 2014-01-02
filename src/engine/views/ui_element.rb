class UIElement
  include HeirarchyMember

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
    options[option]
  end

  def []= option, setting
    options[option] = setting
  end

  def x
    @x ||= 0
  end

  def y
    @y ||= 0
  end

  def h
    @h ||= 0
  end

  def w
    @w ||= 0
  end

  def parent_x
    @parent_x ||= 0
  end
  def parent_y
    @parent_y ||= 0
  end
  def parent_w
    @parent_w ||= 100
  end
  def parent_h
    @parent_h ||= 100
  end

  def on_parent_added parent
    @parent_x = parent.x
    @parent_y = parent.y
    @parent_w = parent.w
    @parent_h = parent.h
  end

  def on_parent_removed parent
    @parent_x = 0
    @parent_y = 0
    @parent_w = 0
    @parent_h = 0
  end

  def options
    @options ||= {}
  end
end
