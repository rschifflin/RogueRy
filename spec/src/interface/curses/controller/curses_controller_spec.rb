require 'spec_helper'

describe CursesController do
  subject(:curses_controller) { CursesController.new(view_keeper: view_keeper, renderer: renderer, interface_wrapper: interface_wrapper) } 
  let(:view_keeper) { double("ViewKeeper") }
  let(:interface_wrapper) { double("InterfaceWrapper") }
  let(:renderer) { double("Renderer") }
  before do
    interface_wrapper.stub(:handle)
    renderer.stub(:render)
  end

  describe("Receiving input") do
    describe("With data the view model can handle") do 
      before { view_keeper.stub(:handle) { :Cosmetic } }
      it "dispatches the message to the view model" do
        view_keeper.should_receive(:handle)
        curses_controller.input("something") 
      end
      it "doesn't dispatch the message to the engine" do
        interface_wrapper.should_not_receive(:handle)
        curses_controller.input("something") 
      end
      it "tells the renderer to render" do
        renderer.should_receive(:render)
        curses_controller.input("something") 
      end
    end

    describe("With data the view model can't handle") do 
      before { view_keeper.stub(:handle) { :Functional } }
      it "doesn't dispatch the message to the renderer" do
        renderer.should_not_receive(:render)
        curses_controller.input("something") 
      end
      it "dispatches the message to the interface wrapper" do
        interface_wrapper.should_receive(:handle)
        curses_controller.input("something") 
      end
    end
  end
end
