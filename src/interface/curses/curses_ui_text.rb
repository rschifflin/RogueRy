require "interface/curses/curses_ui_element"
class CursesUIText < CursesUIElement
  attr_reader :text, :overflow

  def update_from ui_text
    super
    @overflow = ui_text.options[:overflow]
    @text = format_text(ui_text.text)
  end

  def render output
    output = output.dup
    output[y] = output[y].merge(text, x)
    output
  end

private
  def format_text unformatted_text
    self.send(:"format_text_#{overflow}", unformatted_text)
  end

  def format_text_hidden unformatted_text
    unformatted_text.slice(0, [w, parent_w,unformatted_text.length].min ) 
  end

  def format_text_truncate unformatted_text
    if unformatted_text.length > parent_w
      unformatted_text.slice(0, parent_w - 3) + "..." 
    elsif unformatted_text.length > w
      unformatted_text.slice(0, w - 3) + "..." 
    else
      unformatted_text
    end
  end

end
