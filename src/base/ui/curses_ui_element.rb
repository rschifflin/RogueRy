class CursesUIElement
  attr_reader :x, :y
  
  def initialize ui_element
    update_from ui_element
  end

  def update_from ui_element
    @x = ui_element.x
    @y = ui_element.y
    @w = ui_element.w
    @h = ui_element.h

    if ui_element.parent
      @parent_w = ui_element.parent.w
      @parent_h = ui_element.parent.h
    else
      @parent_w = 0
      @parent_h = 0
    end
  end
end
