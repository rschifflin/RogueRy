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
    id_view_map = map_views_by_id(view_keeper.views)
    view_keeper.views = views.each do |view|
      view.copy_cosmetic_state_from(id_view_map[view.id]) if id_view_map[view.id]
    end
  end

private
  def map_views_by_id(views)
    {}.tap do |hsh|
      views.each { |view| hsh[view.id] = view }
    end
  end
end
