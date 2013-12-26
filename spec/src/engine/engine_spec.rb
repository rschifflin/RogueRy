require 'spec_helper'

describe Engine do
  subject(:engine) { Engine.instance }
  let(:renderer) { double('CursesRenderer') }

  before do
    renderer.stub(:clear)
    renderer.stub(:update)
    renderer.stub(:render)
    engine.add_renderer renderer
  end 

  it "is a singleton" do 
    another_engine = Engine.instance 
    expect(engine).to eq(another_engine)
  end

  context "on input" do
    let(:input) { :some_input }
    it "clears the renderer" do
      renderer.should_receive(:clear)
      engine.handle(input);
    end
    it "updates the corresponding ui in the renderer" do
      renderer.should_receive(:update)
      engine.handle(input);
    end
    it "tells the renderer to render" do
      renderer.should_receive(:render)
      engine.handle(input);
    end
  end
end
