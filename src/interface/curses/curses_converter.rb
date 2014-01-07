require "interface/curses/curses_ui_character"
require "interface/curses/curses_ui_text"
require "interface/curses/curses_ui_rect"

class CursesConverter
  def convert views
    views.map do |view|
      view.convert_using(self)
    end
  end

  def create_element_from(template)
    CursesUIElement.new(template)
  end

  def create_character_from(template)
    CursesUICharacter.new(template)
  end

  def create_rect_from(template)
    CursesUIRect.new(template)
  end

  def create_text_from(template)
    CursesUIText.new(template)
  end
end
