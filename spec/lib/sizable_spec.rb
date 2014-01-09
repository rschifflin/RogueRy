require 'spec_helper'
class SizableObject; include Sizable; end

describe Sizable do
  let(:sizable) { SizableObject.new }
  describe "Callbacks" do
    context "when resized" do
      it "calls the on_resize callback" do
        sizable.should_receive(:on_resize)
        sizable.resize(0,0)
      end
    end
  end

  describe "#resize" do
    it "changes the width and height to the given args" do
      sizable.resize(17,21)
      expect([sizable.w, sizable.h]).to eq [17,21]
    end
  end
end
