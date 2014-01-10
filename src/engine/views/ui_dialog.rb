require 'engine/views/ui_element'
require 'engine/views/ui_text'

class UIDialog < UIElement
  def convert_using converter
    converter.create_dialog_from self
  end
end
