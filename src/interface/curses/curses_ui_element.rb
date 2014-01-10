class CursesUIElement
  include HeirarchyMember
  include Movable
  include Sizable
  include Formattable

  attr_reader :id, :tags

  def initialize ui_element
    update_from ui_element
    on_update ui_element
  end

  def update_from ui_element
    @tags = ui_element.tags
    @id = ui_element.id
  end

  def renderable?
    true
  end

  def controllable?
    true
  end

  def render output
    output
  end

private
  def on_update ui_element
  end

  def on_resize
    update_child
  end

  def on_move
    update_child
  end

  def on_offset
    update_child
  end

  def update_child
    children.each do |child| 
      child.offset = [x,y] 
      child.trim_margins(self)
    end
  end

protected
  def on_parent_added parent
    self.offset = [parent.x, parent.y]
  end

  def on_parent_removed parent
    self.offset = [0,0]
  end

  def trim_margins parent
    trimmed_w = [x(relative: true) + w, parent.w - x(relative: true)].min
    trimmed_h = [y(relative: true) + h, parent.h - y(relative: true)].min
    self.resize(trimmed_w, trimmed_h)
  end

end
