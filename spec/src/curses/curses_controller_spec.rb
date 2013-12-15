require 'spec_helper'

describe CursesController do
  subject(:curses_controller) { CursesController.new() } 
  let(:renderer) { double("Renderer") }
  let(:engine) { double("Engine") }
  before do 
    curses_controller.add_engine engine
    curses_controller.add_renderer renderer
    renderer.stub(:can_handle?)
    renderer.stub(:handle)
    engine.stub(:can_handle?)
    engine.stub(:handle)
  end

  describe("Receiving input") do
    it "can accept input" do
      expect { curses_controller.input("something") }.to_not raise_error
    end

    describe("With data the view model can handle") do 
      before { renderer.stub(:can_handle?) { true } } 
      it "dispatches the message to the view model" do
        renderer.should_receive(:handle)
        curses_controller.input("something") 
      end
      it "doesn't dispatch the message to the engine" do
        engine.should_not_receive(:handle)
        curses_controller.input("something") 
      end
    end

    describe("With data the view model can't handle") do 
      before { renderer.stub(:can_handle?) { false } } 
      it "doesn't dispatch the message to the view model" do
        renderer.should_not_receive(:handle)
        curses_controller.input("something") 
      end
      it "dispatches the message to the engine" do
        engine.should_receive(:handle)
        curses_controller.input("something") 
      end
    end
  end
end
