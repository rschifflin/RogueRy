class CursesRenderMapper
  def initialize
    @map = { UICharacter => CursesUICharacter }
  end
  def [] key
    @map[key]
  end
end
