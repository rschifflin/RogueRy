require 'spec_helper'

describe Engine do
  subject(:engine) { Engine.new(interface_wrapper: wrapper) }
  let(:wrapper) { double('CursesInterfaceWrapper') }

  before do
    wrapper.stub(:update)
  end 

  context "on input" do
    let(:input) { :some_input }
    it "sends its views to the wrapper" do
      wrapper.should_receive(:update).with(engine.ui_parent)
      engine.handle(input)
    end
  end
end
