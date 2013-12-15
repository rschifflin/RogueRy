class String
  def merge other_str, index=0
    other_str = other_str.to_s
    head_range = (0...index)
    tail_range = ((other_str.length + index)...self.length)
    head = self.slice(head_range) || ""
    tail = self.slice(tail_range) || ""
    (head + tail).insert(index, other_str)
  end

  def to_camel
    self.split(/ +|_+|-+/).map { |word| word.slice(0).to_s.upcase + word.slice(1,self.length).to_s }.join()
  end 

  def to_mixed
    mixed = self.to_camel
    mixed.slice(0).to_s.downcase + mixed.slice(1,mixed.length).to_s
  end

  def to_snake
    self.split(/ +|_+|-+/).reject{ |e| e == "" }.map do |word| 
      word.split(/([A-Z][^A-Z]*)/).reject{ |e| e == "" }.map do |subword|
        subword.downcase
      end.join('_')
    end.join('_')
  end
end
