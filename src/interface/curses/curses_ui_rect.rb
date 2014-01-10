require "interface/curses/curses_ui_element"

class CursesUIRect < CursesUIElement
  attr_reader :char

  def on_update ui_rect
    @char = ui_rect.char
    self.resize(ui_rect.w, ui_rect.h)
  end

  def render output
    output = output.dup
    h.times do |dy|
      w.times do |dx|
        output[y+dy][x+dx] = char if output[y+dy] && output[y+dy][x+dx]
      end
    end
    output
  end
end
