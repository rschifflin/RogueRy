=begin
  The windowing manager serves as a tree of windows that gets traversed for display purposes. Every node of the tree
  is a window that can be drawn. Each window can have a child window. Only 1 window has focus at any given time.
  Windows hold objects that include the Windowable mixin, which gives them a Draw method.  
=end

require 'spec_helper'

describe WindowManager do

  let(:wm) { WindowManager.new }

  context "Components" do

    it "should always have a root window" do
      expect(wm.root).to_not be_nil
    end

    it "should always have a reference to the current window" do
      expect(wm.current).to_not be_nil
      expect(wm.current).to eq(wm.root)
    end
    
  end
end
