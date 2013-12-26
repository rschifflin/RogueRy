require "engine/views/ui_text"
class UITester
  attr_reader :view_hidden
  attr_reader :view_truncate

  def initialize 
    @view_hidden = UIText.new(nil, "This text should overflow hidden").move(1,1).resize(20,1)
    @view_hidden[:overflow] = :hidden
    @view_truncate = UIText.new(nil, "This text should overflow truncate").move(12,1).resize(20,1)
    @view_truncate[:overflow] = :truncate
  end

  def view
    @view_truncate
  end
end
