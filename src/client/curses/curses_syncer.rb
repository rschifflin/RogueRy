class CursesSyncer
  attr_reader :view_keeper

  def initialize opts={}
    opts = defaults.merge opts
    @view_keeper = opts[:view_keeper]
  end

  def defaults
    {}
  end

  def sync views
    view_keeper.views = views  
  end
end
