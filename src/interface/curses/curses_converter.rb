require "interface/curses/curses_ui_character"
require "interface/curses/curses_ui_text"
require "interface/curses/curses_ui_rect"
require "interface/curses/curses_ui_dialog"

class CursesConverter
  def convert views
    views.map_heirarchy { |view| view.convert_using(self) }
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

  def create_dialog_from(template)
    CursesUIDialog.new(template).resize(20,20).move(17,13)
  end
end
