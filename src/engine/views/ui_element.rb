class UIElement
  include HeirarchyMember
  include Taggable
  include Identifiable

  def convert_using converter
    converter.create_element_from self
  end
end
