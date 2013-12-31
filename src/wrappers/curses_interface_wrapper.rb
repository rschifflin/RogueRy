class CursesInterfaceWrapper
  attr_reader :engine, :renderer, :syncer
  def configure opts={}
    opts = defaults.merge opts
    @engine = opts[:engine]
    @renderer = opts[:renderer]
    @syncer = opts[:syncer]
  end

  def defaults
    {}
  end

  def handle input
    engine.handle input 
  end

  def update views
    syncer.sync(views)
    renderer.render
  end

end
