require "interface/curses/curses_ui_element"
class CursesUICharacter < CursesUIElement
  attr_reader :char
  def update_from ui_character
    super
    @char = ui_character.char
  end

  def render output
    output = output.dup
    output[y][x] = char
    output
  end
end
