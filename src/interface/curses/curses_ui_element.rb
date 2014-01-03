class CursesUIElement
  attr_reader :x, :y, :w, :h

  def initialize ui_element
    update_from ui_element
    on_update ui_element
  end

  def renderable?
    true
  end

  def controllable?
    true
  end

  def on_update ui_element
  end

  def update_from ui_element
    @x = ui_element.x
    @y = ui_element.y
    @w = ui_element.w
    @h = ui_element.h
  end

  def render output
    output
  end
end
