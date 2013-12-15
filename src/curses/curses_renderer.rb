class CursesRenderer < Renderer
  attr_reader :io_wrapper, :output
  def initialize
    @render_mapper = CursesRenderMapper.new
  end

  def add_io_wrapper io_wrapper
    @io_wrapper = io_wrapper
  end

  def clear
    @output = [].tap { |ary| @io_wrapper.lines.times { ary << " " * @io_wrapper.cols } }
  end

  def update ui
    curses_ui_class = @render_mapper[ui.class]
    curses_ui = curses_ui_class.new(ui)
    @output = curses_ui.render @output
  end

  def render
    io_wrapper.output(@output);
  end
end
