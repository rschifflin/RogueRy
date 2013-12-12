class CursesRenderer < Renderer
  attr_reader :io_wrapper, :output
  def add_io_wrapper io_wrapper
    @io_wrapper = io_wrapper
  end

  def clear
    @output = [].tap { |ary| @io_wrapper.lines.times { ary << " " * @io_wrapper.cols } }
  end

  def update element
    @output[element.last][element.first] = '@'
  end

  def render
    io_wrapper.output(@output);
  end
end
