require 'spec_helper'

DummyView = Struct.new(:id, :state) do
  def copy_cosmetic_state_from args
    self.state = 1
  end
end

describe CursesSyncer do
  subject(:syncer) { CursesSyncer.new(view_keeper: view_keeper) }
  let(:view_keeper) { double("ViewKeeper") }
  let(:incoming_views) {  }

  describe "#sync" do
    context "With no pre-existing views in the view keeper" do
      before { view_keeper.stub(:views) { [] } }
      let(:incoming_views) {
        [DummyView.new(135),
         DummyView.new(246),
         DummyView.new(357)]
      }

      it "sets the view_keeper's views equal to the incoming views" do
        view_keeper.should_receive(:views=).with(incoming_views)
        syncer.sync(incoming_views)
      end
    end

    context "With pre-existing views with no matching ids in the view keeper" do
      let(:incoming_views) {
        [DummyView.new(135),
         DummyView.new(246),
         DummyView.new(357)]
      }

      before { 
        view_keeper.stub(:views) { 
          [DummyView.new(123),
           DummyView.new(456),
           DummyView.new(789)]
        } 
      }

      it "sets the view_keeper's views equal to the incoming views" do
        view_keeper.should_receive(:views=).with(incoming_views)
        syncer.sync(incoming_views)
      end
    end

    context "With pre-existing views that have some shared ids" do
      let(:incoming_views) {
        [DummyView.new(135, 0),
         DummyView.new(456, 0),
         DummyView.new(789, 0)]
      }
      let(:outgoing_views) {
        [DummyView.new(135, 0),
         DummyView.new(456, 1),
         DummyView.new(789, 1)]
      }
      before { 
        view_keeper.stub(:views) { 
          [DummyView.new(123, 1),
           DummyView.new(456, 1),
           DummyView.new(789, 1)]
        } 
      }
      it "updates the state of the views with shared ids" do
        view_keeper.should_receive(:views=).with(outgoing_views)
        syncer.sync(incoming_views)
      end
    end
  end

end
