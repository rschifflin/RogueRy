require 'spec_helper'

describe CursesRenderer do
  subject(:curses_renderer) { CursesRenderer.new(view_keeper: curses_view_keeper, io_wrapper: curses_io_wrapper) }
  let(:curses_io_wrapper) { double("CursesIOWrapper") }
  let(:curses_view_keeper) { double("CursesViewKeeper") }
  before do 
    curses_io_wrapper.stub(:output)
    curses_view_keeper.stub(:renderables) { [] }
  end

  describe "Constructing the view model" do
    describe "With input constraints of 24x80" do
      before do
        curses_io_wrapper.stub(:lines) { 24 }
        curses_io_wrapper.stub(:cols) { 80 }
      end

      it "outputs 24 lines of width 80" do
        lines = [].tap { |ary| 24.times { ary << " " * 80 } }
        curses_io_wrapper.should_receive(:output).with(lines);
        curses_renderer.render
      end
    end
  end
end
