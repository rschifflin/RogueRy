module Sizable
  def size
    @size ||= [0,0]
  end

  def w
    size[0] 
  end
  
  def h
    size[1]
  end

  def resize(w,h)
    @size = [w,h]
    on_resize
    self
  end

  def on_resize
  end
end
