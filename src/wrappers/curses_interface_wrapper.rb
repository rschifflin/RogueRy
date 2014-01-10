class CursesInterfaceWrapper
  attr_reader :engine, :renderer, :syncer, :converter, :formatter
  def configure opts={}
    opts = defaults.merge opts
    @engine = opts[:engine]
    @renderer = opts[:renderer]
    @syncer = opts[:syncer]
    @converter = opts[:converter]
    @formatter = opts[:formatter]
  end

  def defaults
    {}
  end

  def handle input
    engine.handle input 
  end

  def update views
    converted_views = converter.convert(views)
    formatted_views = formatter.format(converted_views)
    syncer.sync(formatted_views)
    renderer.render
  end

end
