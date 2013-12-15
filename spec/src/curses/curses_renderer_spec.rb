require 'spec_helper'

describe CursesRenderer do
  subject(:curses_renderer) { CursesRenderer.new }
  let(:curses_io_wrapper) { double("CursesIOWrapper") }
  before do 
    curses_io_wrapper.stub(:output)
    curses_renderer.add_io_wrapper curses_io_wrapper
  end

  describe "#can_handle?" do
    describe "with input it can't handle" do
      it "returns false" do
        expect(curses_renderer.can_handle?(nil)).to be_false
      end
    end 
  end
=begin
  describe "Constructing the view model" do
    describe "With input constraints of 24x80" do
      before do
        curses_io_wrapper.stub(:lines) { 24 }
        curses_io_wrapper.stub(:cols) { 80 }
      end

      describe "Using a UIWanderer ui element as input" do
        let(:ui_element) { double(UIElement) }
        before do 
          ui_element.stub(:pos_y) { 6 }
          ui_element.stub(:pos_x) { 10 }
          ui_element.stub(:char) { ?@ }
          curses_renderer.clear
          curses_renderer.update(ui_element) 
        end

        it "outputs 24 lines of width 80" do
          lines = [].tap { |ary| 24.times { ary << " " * 80 } }
          lines[6][10] = ?@
          curses_io_wrapper.should_receive(:output).with(lines);
          curses_renderer.render
        end
      end
    end
  end
=end
end
