require "interface/curses/curses_ui_element"

class CursesUIRect < CursesUIElement
  attr_reader :char
  def update_from ui_rect
    super
    @char = ui_rect.char
  end

  def render output
    output = output.dup
    h.times do |dy|
      w.times do |dx|
        output[y+dy][x+dx] = char
      end
    end
    output
  end
end
