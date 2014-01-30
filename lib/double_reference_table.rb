#This class provides #insert, #remove, #size through two reference tables. The primary reference is a spatial index, indexed by 2D coords. The indirect reference is a hash of ids that map to the coords of their location in the spatial index.
class DoubleReferenceTable
  attr_writer :spatial_index, :id_index, :size

  def insert x, y, item
    return false if id_index[item]
    spatial_index[x][y] << item
    id_index[item] = [x,y]
    item
  end

  def delete item
    return false unless id_index[item]
    x, y = *id_index[item]
    spatial_index[x][y].delete(item)
    id_index.delete(item)
    item
  end

  def at *args
    spatial_index[args[0]][args[1]]
  end

  def find item
    id_index[item] && id_index[item].dup
  end

  def size
    id_index.size
  end

  def id_index
    @id_index ||= {}
  end

  def spatial_index
    @spatial_index ||= SpatialIndex.new { Array.new }
  end
end
