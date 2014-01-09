require 'spec_helper'
class MovableObject; include Movable; end

describe Movable do
  subject(:movable) { MovableObject.new }
  describe "Callbacks" do
    context "when moved" do
      it "calls the on_move callback" do
        movable.should_receive(:on_move)
        movable.move(0,0)
      end
    end

    context "when given an offset" do
      it "calls the on_offset callback" do
        movable.should_receive(:on_offset)
        movable.offset = [0,0]
      end
    end
  end

  describe "#move" do
    context "With no offset" do
      it "changes the position to the given args" do
        movable.move(3,6)
        expect([movable.x, movable.y]).to eq [3,6]
      end
    end
    context "With an offset" do
      it "changes the position with respect to the offset" do
        movable.offset = [9,12]
        movable.move(5,8)
        expect([movable.x, movable.y]).to eq [14,20]
      end
    end

    context "Using relative coordinates" do
      it "ignores the offset" do
        movable.offset = [9,12]
        movable.move(5,8)
        expect([movable.x(relative: true), movable.y(relative: true)]).to eq [5,8]
      end
    end
  end
end
