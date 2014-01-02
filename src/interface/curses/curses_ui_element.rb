class CursesUIElement
  attr_reader :x, :y, :w, :h, 
    :abs_x, :abs_y, :rel_x, :rel_y,
    :parent_x, :parent_y, :parent_w, :parent_h

  def initialize ui_element
    update_from ui_element
  end

  def renderable?
    true
  end

  def controllable?
    true
  end

  def update_from ui_element
    @abs_x = ui_element.x
    @abs_y = ui_element.y
    @parent_x = ui_element.parent_x
    @parent_y = ui_element.parent_y
    @x = @rel_x = parent_x + abs_x
    @y = @rel_y = parent_y + abs_y

    @w = ui_element.w
    @h = ui_element.h
    @parent_w = ui_element.parent_w
    @parent_h = ui_element.parent_h
  end

  def render output
    output
  end
end
