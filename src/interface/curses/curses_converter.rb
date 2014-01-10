require "interface/curses/curses_ui_character"
require "interface/curses/curses_ui_text"
require "interface/curses/curses_ui_rect"

class CursesConverter
  def convert views
    views.map_heirarchy { |view| view.convert_using(self) }
  end

  def create_element_from(template)
    CursesUIElement.new(template)
  end

  def create_character_from(template)
    CursesUICharacter.new(template).move(3,3).resize(1,1)
  end

  def create_rect_from(template)
    CursesUIRect.new(template).move(3,3)
  end

  def create_text_from(template)
    CursesUIText.new(template)
  end
end
