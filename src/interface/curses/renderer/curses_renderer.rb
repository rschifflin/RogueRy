require "interface/curses/renderer/curses_render_mapper"
require "interface/base/renderer"

class CursesRenderer < Renderer
  attr_reader :io_wrapper, :view_keeper, :output
  def can_handle? input
    false
  end

  def initialize opts={}
    opts = defaults.merge opts
    @io_wrapper = opts[:io_wrapper]
    @view_keeper = opts[:view_keeper]
  end

  def defaults
    {}
  end

  def clear
    @output = [].tap { |ary| io_wrapper.lines.times { ary << " " * io_wrapper.cols } }
  end

  def update 
    @output = view_keeper.renderables.first.render(output)
  end

  def render
    clear
    update
    io_wrapper.output(output);
  end
end
