require "engine/views/ui_rect"
class DebugRect
  def initialize(x,y,w,h,fill)
    @view = UIRect.new(fill).move(x,y).resize(w,h)
  end

  def resize(w,h)
    @view.resize(w,h)
  end

  def move(x,y)
    @view.move(x,y)
  end

  def view
    @view
  end

end
