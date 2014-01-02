class CursesViewKeeper
  def handle input
    input
  end

  def views
    @views || []
  end
  
  def views= new_views
    @views = new_views
  end

  def controllables
    views.select { |view| view.controllable? }
  end

  def renderables
    views.select { |view| view.renderable? }
  end
end
