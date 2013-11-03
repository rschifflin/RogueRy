class Floor

  def initialize
    @object_array = Array.new(100) { |index| Array.new(100, Set.new) }
  end 

  def [] x, y
    @object_array[x][y]
  end

  def []= object, x, y
    @object_array[x][y] << object
  end

  alias at []
  alias insert []=

end
