require 'spec_helper'

describe CursesViewKeeper do
  subject(:view_keeper) { CursesViewKeeper.new }

  describe "#views" do
    context "with no views" do
      it { expect(view_keeper.views).to eq [] } 
    end
  end

  describe "#controllables" do
    context "with no views" do
      it { expect(view_keeper.controllables).to eq [] } 
    end
  end

  describe "#renderables" do
    context "with no views" do
      it { expect(view_keeper.renderables).to eq [] } 
    end
  end
end
