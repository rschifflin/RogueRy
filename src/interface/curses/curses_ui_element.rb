class CursesUIElement
  attr_reader :x, :y, :w, :h, :id

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

  def copy_cosmetic_state_from other_curses_ui_element
    #Cosmetic state, such as current page in pagination, current scroll position, current highlighted option, etc, is preserved in between updates. When a new curses element is created, if it shares the same id as an old curses element, it will copy over its cosmetic state.
    #If the element carries no cosmetic state, don't override this method.
  end

  def update_from ui_element
    @id = ui_element.id
    @x = ui_element.x
    @y = ui_element.y
    @w = ui_element.w
    @h = ui_element.h
  end

  def render output
    output
  end
end
