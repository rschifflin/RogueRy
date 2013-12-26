require "interface/curses/curses_ui_character"
require "interface/curses/curses_ui_text"

class CursesRenderMapper
  def initialize
    @map = { 
      "UICharacter" => CursesUICharacter,
      "UIText" => CursesUIText }
  end

  def [] key
    @map[key]
  end
end
