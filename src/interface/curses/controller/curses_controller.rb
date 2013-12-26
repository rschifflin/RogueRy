class CursesController 

  def add_renderer renderer
    @renderer = renderer
  end

  def add_engine engine
    @engine = engine
  end

  def add_io_wrapper io_wrapper
    @io_wrapper = io_wrapper
  end

  def input input
    @renderer.can_handle?(input) ? @renderer.handle(input) : @engine.handle(input)
  end

end
