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
    10.times do |y|
      @window.setpos(y, 0)
      @window.addstr(' ' * 27)
    end

    @pos = args[0]
    @window.setpos(1 + @pos[1], 1 + @pos[0])
    @window.addch(?*)
    @window.box(?|, ?-)
    @window.setpos(0,0)
    @window.addstr("(#{@pos[0]}, #{@pos[1]})")
    @window.refresh
  end

  def stop
    echo
    close_screen
  end
end
