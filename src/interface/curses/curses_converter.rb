require "interface/curses/curses_ui_character"
require "interface/curses/curses_ui_text"
require "interface/curses/curses_ui_rect"

class CursesConverter
  def convert views
    views.map do |view|
      conversion_table[view.class.to_s].new(view)
    end
  end

  def conversion_table
    @map = { 
      "UIElement" => CursesUIElement,
      "UICharacter" => CursesUICharacter,
      "UIRect" => CursesUIRect,
      "UIText" => CursesUIText }
  end
end
