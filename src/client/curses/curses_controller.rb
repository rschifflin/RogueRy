class CursesController 
  attr_reader :renderer, :view_keeper, :interface_wrapper
  def initialize opts={}
    opts = defaults.merge opts
    @renderer = opts[:renderer]
    @view_keeper = opts[:view_keeper]
    @interface_wrapper = opts[:interface_wrapper]
  end

  def defaults
    {
      renderer: nil,
      view_keeper: nil,
      interface_wrapper: nil
    }
  end

  def input input
    translated_input = view_keeper.handle(input)
    translated_input == :Cosmetic ? renderer.render : interface_wrapper.handle(translated_input)
  end
end
