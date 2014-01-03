require 'spec_helper'
describe UIElement do
  subject(:element) { UIElement.new }

  describe "when adding a parent" do
    let(:parent) { UIElement.new }
    before { parent.add_child(element) }
    context "whose parent position is 21,17, size 11,18" do
      before { parent.move(21,17).resize(11,18) }
      context "using an original position of 3,4, size 8,9" do
        before { element.move(3,4).resize(8,9) }
        it "updates its relative x,y" do
          expect(element.screen_x).to eq(21+3)
          expect(element.screen_y).to eq(17+4)
        end
        it "updates its relative parent_x, parent_y" do
          expect(element.parent_screen_x).to eq(11+8)
          expect(element.parent_screen_y).to eq(18+9)
        end
      end
    end
  end

  describe "when removing a parent" do

  end

  describe "when moving" do

  end

  describe "when resizing" do

  end

end
