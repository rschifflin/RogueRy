require "interface/curses/curses_ui_element"
class CursesUIText < CursesUIElement
  attr_reader :text, :overflow

  def on_update ui_text
    @overflow = ui_text.options[:overflow]
    @text = format_text(ui_text.text)
  end

  def render output
    output = output.dup
    output[y] = output[y].merge(text, x) if output[y]
    output
  end

private
  def format_text unformatted_text
    self.send(:"format_text_#{overflow}", unformatted_text)
  end

  def format_text_hidden unformatted_text
    unformatted_text.slice(0, [w, unformatted_text.length].min ) 
  end

  def format_text_truncate unformatted_text
    if unformatted_text.length > w
      unformatted_text.slice(0, w - 3) + "..." 
    else
      unformatted_text
    end
  end

end
