require 'spec_helper'

describe CursesInterfaceWrapper do
  subject(:wrapper) { CursesInterfaceWrapper.new }
  let(:syncer) { double("CursesSyncer") }
  let(:renderer) { double("CursesRenderer") }
  before { wrapper.configure(syncer: syncer, renderer: renderer) }

  describe "#update" do
    before do
      syncer.stub(:sync)
      renderer.stub(:render)
    end

    it "tells the syncer to sync" do
      syncer.should_receive(:sync)
      wrapper.update(nil)
    end

    it "tells the renderer to render" do
      renderer.should_receive(:render)
      wrapper.update(nil)
    end
  end
end
