class CursesController 
  def initialize opts={}
    opts = defaults.merge opts
    @renderer = opts[:renderer]
    @engine = opts[:interface_wrapper]
    @io_wrapper = opts[:io_wrapper]
  end

  def defaults
    {
      renderer: nil,
      interface_wrapper: nil,
      io_wrapper: nil
    }
  end

  def input input
    renderer.can_handle?(input) ? renderer.handle(input) : engine.handle(input)
  end

  def io_wrapper
    @io_wrapper || raise("No IO wrapper provided")
  end

  def engine
    @engine || raise("No engine provided")
  end

  def renderer
    @renderer || raise("No renderer provided")
  end
end
