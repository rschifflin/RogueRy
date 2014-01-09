module Movable
  def offset= offset
    @offset = offset
    on_offset
  end

  def x(opts = {relative: false})
    opts[:relative] ? position[0] : position[0] + offset[0] 
  end

  def y(opts = {relative: false})
    opts[:relative] ? position[1] : position[1] + offset[1] 
  end

  def move(x,y)
    @position = [x,y]
    on_move
    self
  end

  def on_move
  end

  def on_offset
  end

private
  def position
    @position ||= [0,0]
  end

  def offset
    @offset ||= [0,0]
  end


end
