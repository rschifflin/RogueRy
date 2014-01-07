class CursesInterfaceWrapper
  attr_reader :engine, :renderer, :syncer, :converter
  def configure opts={}
    opts = defaults.merge opts
    @engine = opts[:engine]
    @renderer = opts[:renderer]
    @syncer = opts[:syncer]
    @converter = opts[:converter]
  end

  def defaults
    {}
  end

  def handle input
    engine.handle input 
  end

  def update views
    converted_views = converter.convert(views)
    syncer.sync(converted_views)
    renderer.render
  end

end
