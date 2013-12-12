require 'spec_helper'

describe CursesController do
  subject(:curses_controller) { CursesController.new(view_model, engine) } 
  let(:view_model) { double("ViewModel") }
  let(:engine) { double("Engine") }
  before do 
    view_model.stub(:can_handle?)
    view_model.stub(:handle)
    engine.stub(:can_handle?)
    engine.stub(:handle)
  end

  describe("Receiving input") do
    it "can accept input" do
      expect { curses_controller.input("something") }.to_not raise_error
    end

    describe("With data the view model can handle") do 
      before { view_model.stub(:can_handle?) { true } } 
      it "dispatches the message to the view model" do
        view_model.should_receive(:handle)
        curses_controller.input("something") 
      end
      it "doesn't dispatch the message to the engine" do
        engine.should_not_receive(:handle)
        curses_controller.input("something") 
      end
    end

    describe("With data the view model can't handle") do 
      before { view_model.stub(:can_handle?) { false } } 
      it "doesn't dispatch the message to the view model" do
        view_model.should_not_receive(:handle)
        curses_controller.input("something") 
      end
      it "dispatches the message to the engine" do
        engine.should_receive(:handle)
        curses_controller.input("something") 
      end
    end
  end
end
