require "client/curses/curses_ui_element"
class CursesUICharacter < CursesUIElement
  attr_reader :char
  def on_update ui_character
    @char = ui_character.char
  end

  def render output
    output = output.dup
    output[y][x] = char if output[y] && output[y][x]
    output
  end
end
