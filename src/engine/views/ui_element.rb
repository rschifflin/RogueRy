class UIElement
  include HeirarchyMember

  def move(x,y)
    pos_base.move(x,y)
    calc_new_pos
    self
  end

  def resize(w, h)
    pos_base.resize(w,h)
    calc_new_pos
    self
  end

  def [] option
    options[option]
  end

  def []= option, setting
    options[option] = setting
  end

  def x
    pos_final.x 
  end

  def y
    pos_final.y
  end

  def h
    pos_final.h
  end

  def w
    pos_final.w
  end

  def parent_x
    root? ? 0 : pos_parent.x
  end

  def parent_y
    root? ? 0 : pos_parent.y
  end

  def parent_w
    root? ? 0 : pos_parent.w
  end

  def parent_h
    root? ? 0 : pos_parent.h
  end

  def on_parent_added parent
    self.pos_parent = Rect.new(x: parent.x, y: parent.y, w: parent.w, h: parent.h)
  end

  def on_parent_removed parent
    self.pos_parent = nil
  end

  def root?
    @pos_parent.nil?
  end

  def options
    @options ||= {}
  end

private
  def pos_base
    @pos_base ||= Rect.new
  end

  def pos_parent
    @pos_parent 
  end

  def pos_final
    @pos_final ||= Rect.new
  end

  def calc_new_pos
    unless root?
      pos_final_unclipped = Rect.offset_of_rects(pos_base, pos_parent)
      @pos_final = Rect.intersection_of_rects(pos_final_unclipped, pos_parent)
    else
      @pos_final = pos_base
    end
    children.each { |child| child.pos_parent = @pos_final }
  end

protected
  def pos_parent= parent
    @pos_parent = parent.nil? ? nil : Rect.new(x: parent.x, y: parent.y, w: parent.w, h: parent.h)
    calc_new_pos
  end

end
