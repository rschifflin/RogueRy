require 'curses'
require 'io_wrapper'
include Curses

class CursesIOWrapper < IOWrapper
  def start
    begin
      init_screen
      noecho
      @window = Window.new(10, 25, 0, 0)
    rescue
      stop and return false
    end
  end

  def input
    getch
  end

  def output(*args, &block)
    @window.setpos(1,1)
    @window.addstr(args[0])
    @window.box(?|, ?-)
    @window.refresh
  end

  def stop
    echo
    close_screen
  end
end
