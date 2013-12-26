require "engine/views/ui_character"
class Wanderer
  attr_accessor :x, :y
  attr_reader :view

  def initialize xpos, ypos
    self.x = xpos
    self.y = ypos
    
    @view = UICharacter.new ?@
  end

  def view
    @view.move(x,y)
  end

  def pos
    [x, y]
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
