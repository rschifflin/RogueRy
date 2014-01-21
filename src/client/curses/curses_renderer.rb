require "client/base/renderer"
class CursesRenderer < Renderer
  attr_reader :io_wrapper, :view_keeper, :output

  def initialize opts={}
    opts = defaults.merge opts
    @io_wrapper = opts[:io_wrapper]
    @view_keeper = opts[:view_keeper]
  end

  def defaults
    {}
  end

  def clear
    @output = empty_screen
  end

  def empty_screen
    [].tap { |ary| io_wrapper.lines.times { ary << " " * io_wrapper.cols } }
  end

  def update 
    composed_output = view_keeper.renderables.inject(empty_screen) { |out, r| r.render(out) }
    @output = composed_output if composed_output
  end

  def render
    clear
    update
    io_wrapper.output(output)
  end
end
