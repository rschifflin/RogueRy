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

private
  def map_views_by_id(views)
    {}.tap do |hsh|
      views.each { |view| hsh[view.id] = view }
    end
  end
end
