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

  def update_view
    @view.move(x,y)
  end

  def pos
    [x, y]
  end

  def left
    self.x -= 1
    update_view
  end

  def right
    self.x += 1
    update_view
  end

  def up
    self.y -=1
    update_view
  end

  def down
    self.y += 1
    update_view
  end

end
