require 'negative_allowed_array'
class SpatialIndex
  include Enumerable
  attr_reader :base_array

  def initialize 
    @base_array = NegativeAllowedArray.new
    def @base_array.[](index) 
      return self.at(index) if self.at(index)
      lazy_array = NegativeAllowedArray.new
      def lazy_array.[](index)
        self.at(index) ? self.at(index) : self[index] = []
      end
      self[index] = lazy_array
    end
  end

  def each(&block)
    base_array.compact.each { |sub_array| sub_array.compact.reject { |obj| obj == [] }.each(&block) }
  end

  def each_with_indices(&block)
    base_array.inject(base_array.start) do |i, sub_array|
      sub_array.inject(sub_array.start) do |j, obj|
        yield(obj, i, j) if obj && !obj.empty?
        j + 1
      end if sub_array && !sub_array.empty?
      i + 1
    end
  end

  def [](index)
    base_array[index]
  end

end
