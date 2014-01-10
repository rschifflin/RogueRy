require 'spec_helper'

describe CursesSyncer do
  subject(:syncer) { CursesSyncer.new(view_keeper: view_keeper) }
  let(:view_keeper) { double("ViewKeeper") }
  let(:incoming_views) { nil }

  describe "#sync" do
    before { view_keeper.stub(:views) { [] } }
    it "sets the view_keeper views to the synced views" do
      view_keeper.should_receive("views=").with(incoming_views)
      syncer.sync(incoming_views)
    end
  end
end
