class CursesFormatter
  def format views
    views.each do |view| 
      view.tags.each { |tag| self.send("format_tag_#{tag}", view ) }
    end
    views
  end

  def format_tag_bg_light(view)
    view.background = ?.
  end

  def format_tag_title(view)
    view.move(10,1)
  end

  def format_tag_body(view)
    view.move(5, 5)
  end
end 
