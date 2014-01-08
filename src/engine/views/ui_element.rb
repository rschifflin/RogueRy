class UIElement
  include HeirarchyMember
  include Identifiable

  def convert_using converter
    converter.create_element_from self
  end

  def [] option
    options[option]
  end

  def []= option, setting
    options[option] = setting
  end

  def options
    @options ||= {}
  end

end
