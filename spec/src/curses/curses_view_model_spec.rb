require 'spec_helper'

describe CursesViewModel do
  subject(:curses_view_model) { CursesViewModel.new }
  let(:curses_io_wrapper) { double("CursesIOWrapper") }
  before do 
    curses_io_wrapper.stub(:output)
    curses_view_model.add_io_wrapper curses_io_wrapper
  end

  describe "#can_handle?" do
    describe "with input it can't handle" do
      it "returns false" do
        expect(curses_view_model.can_handle?(nil)).to be_false
      end
    end 
  end

  describe "Constructing the view model" do
    describe "Using a UIWanderer ui element as input" do
      let(:ui_element) { double("UIWanderer") }
      before { curses_view_model.construct(ui_element) }

      it "outputs 24 lines of width 80" do
        lines = [].tap { |ary| 24.times { ary << " " * 80 } }
        curses_io_wrapper.should_receive(:output).with(lines);

        curses_view_model.draw
      end
    end
  end
end
