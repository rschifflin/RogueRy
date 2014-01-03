require 'spec_helper'
describe UIElement do
  subject(:element) { UIElement.new }

  describe "when adding a parent" do
    let(:parent) { UIElement.new.resize(100,100) }
    before { parent.add_child(element) }
    context "whose parent position is 21,17, size 11,18" do
      before { parent.move(21,17).resize(11,18) }
      context "using an original position of 3,4, size 8,9" do
        before { element.move(3,4).resize(36,9) }
        it "updates its final x,y" do
          expect(element.x).to eq(21+3)
          expect(element.y).to eq(17+4)
        end
        it "updates its parent_x, parent_y" do
          expect(element.parent_x).to eq(21)
          expect(element.parent_y).to eq(17)
        end
        it "clips its w, h to fit the parent" do
          expect(element.w).to eq(8)
          expect(element.h).to eq(9)
        end
      end
    end
  end

  describe "when removing a parent" do
    let(:parent) { UIElement.new.resize(100,100) }
    before { parent.add_child(element) }
    context "whose parent position is 21,17, size 11,18" do
      before { parent.move(21,17).resize(11,18) }
      context "using an original position of 3,4, size 36,9" do
        before { element.move(3,4).resize(36,9) }
        before { parent.remove_child(element) }
        it "updates its final x,y" do
          expect(element.x).to eq(3)
          expect(element.y).to eq(4)
        end
        it "updates its parent_x, parent_y" do
          expect(element.parent_x).to eq(0)
          expect(element.parent_y).to eq(0)
        end
        it "updates its width and height" do
          expect(element.w).to eq(36)
          expect(element.h).to eq(9)
        end
      end
    end
  end

  describe "when moving a parent" do
    let(:parent) { UIElement.new.resize(100,100) }
    before { parent.add_child(element) }
    context "whose parent position is 21,17, size 11,18" do
      before { parent.move(21,17).resize(11,18) }
      context "using an original position of 3,4, size 8,9" do
        before { element.move(3,4).resize(8,9) }
        context "moving the parent to [5,3]" do
          before { parent.move(5,3) }
          it "updates its final x,y" do
            expect(element.x).to eq(8)
            expect(element.y).to eq(7)
          end
          it "updates its parent_x, parent_y" do
            expect(element.parent_x).to eq(5)
            expect(element.parent_y).to eq(3)
          end
          it "updates its width and height" do
            expect(element.w).to eq(8)
            expect(element.h).to eq(9)
          end
        end
      end
    end
  end

  describe "when resizing a parent" do
    let(:parent) { UIElement.new.resize(100,100) }
    before { parent.add_child(element) }
    context "whose parent position is 21,17, size 11,18" do
      before { parent.move(21,17).resize(11,18) }
      context "using an original position of 3,4, size 8,9" do
        before { element.move(3,4).resize(8,9) }
        context "resizing the parent so that the child is no longer visible" do
          before { parent.resize(2,6) }
          it "updates its final x,y" do
            expect(element.x).to eq(0)
            expect(element.y).to eq(0)
          end
          it "updates its parent_x, parent_y" do
            expect(element.parent_x).to eq(21)
            expect(element.parent_y).to eq(17)
          end
          it "updates its width and height" do
            expect(element.w).to eq(0)
            expect(element.h).to eq(0)
          end
        end
        context "resizing the parent so that the child must shrink" do
          before { parent.resize(5,7) }
          it "updates its final x,y" do
            expect(element.x).to eq(24)
            expect(element.y).to eq(21)
          end
          it "updates its parent_x, parent_y" do
            expect(element.parent_x).to eq(21)
            expect(element.parent_y).to eq(17)
          end
          it "updates its width and height" do
            expect(element.w).to eq(2)
            expect(element.h).to eq(3)
          end
        end
      end
    end
  end
end
