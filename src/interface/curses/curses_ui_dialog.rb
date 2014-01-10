require "interface/curses/curses_ui_element"

class CursesUIDialog < CursesUIElement
  attr_writer :background
  def render output
    output = output.dup
    h.times do |dy|
      w.times do |dx|
        output[y+dy][x+dx] = background if output[y+dy] && output[y+dy][x+dx] 
      end
    end
    output
  end

  def background
    @background || ' '
  end
end
