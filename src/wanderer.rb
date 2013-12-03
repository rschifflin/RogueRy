class Wanderer
  attr_accessor :x, :y

  def initialize xpos, ypos
    self.x = xpos
    self.y = ypos
  end

  def pos
    [x,y]
  end

  def left
    self.x -= 1
  end

  def right
    self.x += 1
  end

  def up
    self.y -=1
  end

  def down
    self.y += 1
  end

end
