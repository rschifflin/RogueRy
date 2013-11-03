require 'spec_helper'

describe Engine do
  subject(:engine) { Engine.instance }
  let(:mock_io) { IOWrapper.new }
  before { engine.stub(:enter_loop) }

  it "is a singleton" do 
      another_engine = Engine.instance 
      expect(engine).to eq(another_engine)
  end

  context "before starting" do
    describe "#start" do
      it "calls the IO wrapper to start" do
        mock_io.should_receive(:start)
        subject.start(mock_io)
      end
    end

    describe "#stop" do
      it "ignores the command" do
        mock_io.should_not_receive(:stop)
        subject.stop
      end
    end
  end
    
  context "after having started" do
    before { subject.start(mock_io) }
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
      it "tells the io wrapper to stop" do
        mock_io.should_receive(:stop)
        subject.stop
      end
    end

    describe "#draw" do
      it "sends 'Hello World' to io" do
        mock_io.should_receive(:output) { "Hello World" }
        subject.draw
      end
    end

    describe "#read_input" do
    end

  end
end
