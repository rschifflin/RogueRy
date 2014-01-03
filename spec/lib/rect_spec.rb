require 'spec_helper'

describe Rect do
  let(:rect) { Rect.new(x: 0, y: 0, w: 0, h: 0) }
  describe "#rect_within" do
    let(:other) { Rect.new(x: 10, y: 10, w: 10, h: 10) }
    context "With two rects that don't overlap" do
      before { rect.move(0,0).resize(3,3) }
      it "Returns an empty rect of 0,0,0,0" do
        new_rect = Rect.intersection_of_rects(rect, other)
        expect(new_rect.properties).to eq [0,0,0,0]
      end
    end

    context "With the child wholly within the container rect" do
      before { rect.move(14,14).resize(3,3) }
      it "Returns an identical child rect of 14,14,3,3" do
        new_rect = Rect.intersection_of_rects(rect, other)
        expect(new_rect.properties).to eq [14,14,3,3]
      end
    end
    context "With the container wholly within the child rect" do
      before { rect.move(8,8).resize(20,20) }
      it "Returns a rect equivalent to the container" do
        new_rect = Rect.intersection_of_rects(rect, other)
        expect(new_rect.properties).to eq [10,10,10,10]
      end
    end
    context "With the rect partially included on the topleft" do
      before { rect.move(5,8).resize(7,8) }
      it "Returns just the area overlapping in the container" do
        new_rect = Rect.intersection_of_rects(rect, other)
        expect(new_rect.properties).to eq [10,10,2,6]
      end
    end
    context "With the rect partially included on the topright" do
      before { rect.move(17,7).resize(6,11) }
      it "Returns just the area overlapping in the container" do
        new_rect = Rect.intersection_of_rects(rect, other)
        expect(new_rect.properties).to eq [17,10,3,8]
      end
    end
    context "With the rect partially included on the bottomleft" do
      before { rect.move(9,18).resize(4,4) }
      it "Returns just the area overlapping in the container" do
        new_rect = Rect.intersection_of_rects(rect, other)
        expect(new_rect.properties).to eq [10,18,3,2]
      end
    end
    context "With the rect partially included on the bottomright" do
      before { rect.move(11,17).resize(21,12) }
      it "Returns just the area overlapping in the container" do
        new_rect = Rect.intersection_of_rects(rect, other)
        expect(new_rect.properties).to eq [11,17,9,3]
      end
    end

  end
end
