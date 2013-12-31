class CursesSyncer
  attr_reader :view_keeper

  def initialize opts={}
    opts = defaults.merge opts
    @view_keeper = opts[:view_keeper]
    @render_mapper = CursesRenderMapper.new
  end

  def defaults
    {}
  end

  def sync views
    views = [views]
    view_keeper.views = views.map do |ui|
      @render_mapper[ui.class.to_s].new(ui)
    end
  end
end
