require 'spec_helper'

describe Engine do
  subject(:engine) { Engine.instance }
  let(:mock_draw) { IOWrapper.new }
  let(:mock_input) { IOWrapper.new }
  let(:mock_component) do
    { input: mock_input, draw: mock_draw }
  end

  before do
   engine.stub(:component) { mock_component }
   engine.stub(:enter_loop) 
  end 

  it "is a singleton" do 
      another_engine = Engine.instance 
      expect(engine).to eq(another_engine)
  end

  context "before starting" do
    describe "#start" do
      it "sets up the input component" do
        mock_input.should_receive(:start)
        engine.start
      end
      it "sets up the draw component" do
        mock_draw.should_receive(:start)
        engine.start
      end
    end

    describe "#stop" do
      it "ignores the command" do
        mock_input.should_not_receive(:stop)
        mock_draw.should_not_receive(:stop)
        engine.stop
      end
    end
  end
    
  context "after having started" do
    before { subject.start }
    describe "#start" do
      let(:another_mock_io) { IOWrapper.new }
      it "stops the old io wrapper" do
        mock_io.should_receive(:stop)
        subject.start(another_mock_io)
      end

      it "starts the new io wrapper" do
        another_mock_io.should_receive(:start)
        subject.start(another_mock_io)
      end
    end

    describe "#stop" do
      it "tells the io wrappers to stop" do
        mock_input.should_receive(:stop)
        mock_draw.should_receive(:stop)
        engine.stop
      end
    end
  end
end
