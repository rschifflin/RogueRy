module HeirarchyMember
  attr_reader :order
  include Enumerable

  def children
    @children ||= []
  end

  def add_children *incoming_children
    incoming_children.each { |child| add_child(child) }
  end

  def add_child child
    children << child 
    child.on_parent_added self
  end

  def remove_child child
    deleted = @children.reject!{ |member| member == child }
    child.on_parent_removed(self) if deleted
  end

  def remove_all_children
    @children.each{ |child| child.on_parent_removed(self) }
    @children = []
  end

  def on_parent_added parent
  end

  def on_parent_removed parent
  end

  def children
    @children ||= [] 
  end

  def visit_in ordering
    @order = ordering if orderings.include? ordering 
    return self
  end

  def order
    @order ||= :preorder
  end

  def map_heirarchy &block
    head = yield self
    children.each do |child|
      head.add_child(child.visit_in(:preorder).map_heirarchy(&block))
    end
    head
  end

  def orderings
    %i(preorder, postorder)
  end

  def each(&block)
    yield self if order == :preorder
    children.each do |child| 
      child.visit_in(order).each(&block)
    end
    yield self if order == :postorder
  end

end
