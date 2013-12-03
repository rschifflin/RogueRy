require 'spec_helper'

describe Dispatcher do
  subject(:dispatcher) { Dispatcher.new }
  let(:listener) { Object.new }
  before { dispatcher.subscribe(listener, :input, :callback) }

  it "fires callbacks on a listener when the given input is dispatched" do
    listener.should_receive(:callback)
    dispatcher.dispatch(:input)
  end

  context "with no matching input" do
    it "doesn't trigger any callbacks" do
      listener.should_not_receive(:callback)
      dispatcher.dispatch(:unknown)
    end
  end

  context "with a callback that returns false" do
    let(:another_listener) { Object.new }
    before do 
      dispatcher.subscribe(another_listener, :input, :callback) 
      listener.stub(:callback) { false }
    end
    it "continues to fire callbacks" do
      another_listener.should_receive(:callback)
      dispatcher.dispatch(:input)
    end
  end

  context "with a callback that returns true" do
    let(:another_listener) { Object.new }
    before do 
      dispatcher.subscribe(another_listener, :input, :callback) 
      listener.stub(:callback) { true }
    end
    it "consumes the input and stops firing callbacks" do
      another_listener.should_not_receive(:callback)
      dispatcher.dispatch(:input)
    end
  end

  context "With a given priority" do
    let(:low_priority_listener) { Object.new }
    let(:high_priority_listener) { Object.new }
    before do 
      low_priority_listener.stub(:callback) { true }
      high_priority_listener.stub(:callback) { true }
      dispatcher.subscribe(low_priority_listener, :command, :callback, 0) 
      dispatcher.subscribe(high_priority_listener, :command, :callback, 10) 
    end

    it "sends commands in order of priority" do
      high_priority_listener.should_receive(:callback)
      low_priority_listener.should_not_receive(:callback)
      dispatcher.dispatch(:command)
    end
  end
end
