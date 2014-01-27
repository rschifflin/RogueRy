class World
  attr_writer :collection
  def spawn obj, x=0, y=0
    self[x,y] = obj
  end

  def [](*args)
    x, y = args[0], args[1]
    collection.at(x,y)
  end
  alias :at :[]

  def find(entity)
    collection.find(entity)
  end

  def move_north(entity)
    return false unless pos = collection.find(entity)
    pos[1] += 1
    collection.delete(entity)
    collection.insert(*pos, entity)
    true
  end
  def move_south(entity)
    return false unless pos = collection.find(entity)
    pos[1] -= 1
    collection.delete(entity)
    collection.insert(*pos, entity)
    true
  end
  def move_east(entity)
    return false unless pos = collection.find(entity)
    pos[0] += 1
    collection.delete(entity)
    collection.insert(*pos, entity)
    true
  end
  def move_west(entity)
    return false unless pos = collection.find(entity)
    pos[0] -= 1
    collection.delete(entity)
    collection.insert(*pos, entity)
    true
  end

private

  def []=(*args)
    collection.insert(*args)
  end

  def collection
    @collection ||= DoubleReferenceTable.new
  end
end
