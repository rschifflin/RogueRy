class CursesRenderMapper
  def initialize
    @map = { 
      UICharacter => CursesUICharacter,
      UIText => CursesUIText }

  end
  def [] key
    @map[key]
  end
end
