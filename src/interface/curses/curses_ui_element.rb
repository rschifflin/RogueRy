class CursesUIElement
  attr_reader :x, :y, :w, :h, 
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
    @x = ui_element.x
    @y = ui_element.y
    @w = ui_element.w
    @h = ui_element.h

    if ui_element.parent
      @parent_x = ui_element.parent.x
      @parent_y = ui_element.parent.y
      @parent_w = ui_element.parent.w
      @parent_h = ui_element.parent.h
    else
      @parent_x = 0
      @parent_y = 0
      @parent_w = 100
      @parent_h = 100
    end
  end
end
