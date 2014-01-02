require "interface/curses/curses_ui_character"
require "interface/curses/curses_ui_text"
require "interface/curses/curses_ui_rect"

class CursesRenderMapper
  def initialize
    @map = { 
      "UIElement" => CursesUIElement,
      "UICharacter" => CursesUICharacter,
      "UIRect" => CursesUIRect,
      "UIText" => CursesUIText }
  end

  def [] key
    @map[key]
  end
end
