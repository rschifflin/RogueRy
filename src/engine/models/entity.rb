class Entity
  attr_reader :world, :log
  def initialize(args = {})
    opts = defaults.merge args 
    @world = opts[:world]
    @log = opts[:log]
  end

  def defaults
    { world: nil, log: nil }
  end

  def move_north
    world.move_north(self) ? log.log("You moved north!") : log.log("You can't move north!")
  end

  def move_south
    world.move_south(self) ? log.log("You moved south!") : log.log("You can't move south!")
  end
  def move_east
    world.move_east(self) ? log.log("You moved east!") : log.log("You can't move east!")
  end
  def move_west
    world.move_west(self) ? log.log("You moved west!") : log.log("You can't move west!")
  end

  def pos
    world.find(self)
  end

end
