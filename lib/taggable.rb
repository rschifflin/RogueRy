require 'set'
module Taggable
  def add_tag new_tag
    @tags = tags.add(new_tag)
    self
  end

  def tags
    @tags ||= Set.new
  end
end
