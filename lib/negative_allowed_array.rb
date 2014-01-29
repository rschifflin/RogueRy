class NegativeAllowedArray
  def initialize
    @_internal_array = []
    @_internal_offset = 0
  end

  def []= index, value
    if index + _internal_offset < 0
      prepend_array_by((-1*index) - _internal_offset)
    end
    _internal_array[index + _internal_offset]= value
  end

  def [] index
    if index + _internal_offset < 0
      prepend_array_by((-1*index) - _internal_offset)
    end
    _internal_array[index + _internal_offset]
  end
  alias :at :[]

  def method_missing(name, *args, &block)
    if _internal_array.respond_to?(name)
      _internal_array.send(name, *args, &block)
    else
      super
    end
  end

  def respond_to_missing?(name, include_private = false)
    _internal_array.respond_to_missing?(name, include_private) || super 
  end

private
  attr_reader :_internal_array
  attr_reader :_internal_offset

  def prepend_array_by(size)
    size.times { _internal_array.unshift nil }
    @_internal_offset += size
  end
end
