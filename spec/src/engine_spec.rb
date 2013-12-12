require 'spec_helper'

describe Engine do
  subject(:engine) { Engine.instance }
  let(:view_model) { double('CursesViewModel') }
  let(:mock_component) do
    { view_model: view_model }
  end

  before do
   engine.stub(:component) { mock_component }
   engine.stub(:enter_loop) 
  end 

  it "is a singleton" do 
    another_engine = Engine.instance 
    expect(engine).to eq(another_engine)
  end

  context "on input" do
    let(:input) { :some_input }
    it "outputs the corresponding ui to the view model" do
      view_model.should_receive(:construct)
      engine.handle(input);
    end
  end

  context "before starting" do
    describe "#start" do
      it "sets up the input component" do
      end
      it "sets up the draw component" do
      end
    end

    describe "#stop" do
      it "ignores the command" do
      end
    end
  end
    
  context "after having started" do
    before { subject.start }
    describe "#start" do
    end
    describe "#stop" do
    end

  end
end
