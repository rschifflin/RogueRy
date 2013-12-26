class Renderer
  def can_handle? input
    raise NotImplementedError
  end

  def handle input
    raise NotImplementedError
  end
end
