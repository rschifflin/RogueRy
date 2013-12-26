require 'curses'
require 'wrappers/io_wrapper'
include Curses

class CursesIOWrapper < IOWrapper
  def run &block
    start
    yield
    stop
  end

  def start
    begin
      init_screen
      noecho
      curs_set 0
      @window = Window.new(lines, cols, 0, 0)
    rescue
      stop and return false
    end
  end

  def input
    return getch
  end

  def output(lines)
    clear_window
    lines.length.times do |y|
      @window.setpos(y, 0)
      @window.addstr(lines[y])
    end
    @window.box(?|, ?-)
    @window.refresh
  end

  def stop
    echo
    curs_set 1
    close_screen
  end

  def lines
    Curses.lines
  end

  def cols
    Curses.cols
  end

private

  def clear_window
    lines.times do |y|
      @window.setpos(y, 0)
      @window.addstr(' ' * cols)
    end
  end
end
