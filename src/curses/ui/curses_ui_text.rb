class CursesUIText
  def update_from ui_text
    super
    @x = ui_text.x
    @y = ui_text.y
    @text = ui_text.text
    @overflow = ui_text.options[:overflow]
  end

  def render output
    output = output.dup
    output[y] = output[y].merge(text, x)
    output
  end
end
