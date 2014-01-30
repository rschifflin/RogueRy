class NegativeAllowedArray
  def initialize
    @internal_array = []
    @internal_offset = 0
  end

  def start
    -1 * @internal_offset
  end

  def []= index, value
    if index + internal_offset < 0
      prepend_array_by((-1*index) - internal_offset)
    end
    internal_array[index + internal_offset]= value
  end

  def [] index
    if index + internal_offset < 0
      prepend_array_by((-1*index) - internal_offset)
    end
    internal_array[index + internal_offset]
  end
  alias :at :[]

  def method_missing(name, *args, &block)
    if internal_array.respond_to?(name)
      internal_array.send(name, *args, &block)
    else
      super
    end
  end

  def respond_to_missing?(name, include_private = false)
    internal_array.respond_to_missing?(name, include_private) || super 
  end

private
  attr_reader :internal_array
  attr_reader :internal_offset

  def prepend_array_by(size)
    size.times { internal_array.unshift nil }
    @internal_offset += size
  end
end
