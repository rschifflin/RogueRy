require "client/curses/curses_ui_element"
class CursesUIText < CursesUIElement
  attr_reader :text, :overflow

  def on_update ui_text
    @text = ui_text.text
  end

  def render output
    output = output.dup
    output[y] = output[y].merge(text, x) if output[y]
    output
  end

end
