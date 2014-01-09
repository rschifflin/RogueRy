class CursesUIElement
  include HeirarchyMember
  include Movable
  include Sizable

  attr_reader :id

  def initialize ui_element
    update_from ui_element
    on_update ui_element
  end

  def update_child_offset
    children.each { |child| child.offset = [x,y] }
  end

  def on_resize
    update_child_offset 
  end

  def on_move
    update_child_offset
  end

  def on_offset
    update_child_offset
  end

  def on_parent_added parent
    self.offset = [parent.x, parent.y]
  end

  def on_parent_removed parent
    self.offset = [0,0]
  end

  def renderable?
    true
  end

  def controllable?
    true
  end

  def on_update ui_element
  end

  def update_from ui_element
    @id = ui_element.id
  end

  def render output
    output
  end
end
