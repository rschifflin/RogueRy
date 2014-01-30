class Surroundings
  attr_reader :spatial_index, :origin
  attr_accessor :origin

  def initialize
    @spatial_index = SpatialIndex.new
    @origin = [0,0]
  end
  def []= x, y, val
    x_from_origin = x + origin[0]
    y_from_origin = y + origin[1]
    spatial_index[x_from_origin][y_from_origin] = val
  end
  def [] x, y
    x_from_origin = x + origin[0]
    y_from_origin = y + origin[1]
    spatial_index[x_from_origin][y_from_origin] 
  end

  def each(&block)
    spatial_index.each(&block)
  end

  def each_with_indices(&block)
    spatial_index.each_with_indices(&block)
  end

  def append other_surroundings
    other_surroundings.each_with_indices do |cell, x, y|
      [x + origin[0]][y + origin[1]] = cell
    end

    self.origin = other_surroundings.origin.dup
  end

end
