require 'spec_helper'

describe CursesInterfaceWrapper do
  subject(:wrapper) { CursesInterfaceWrapper.new }
  let(:converter) { double("CursesConverter") }
  let(:formatter) { double("CursesFormatter") }
  let(:syncer) { double("CursesSyncer") }
  let(:renderer) { double("CursesRenderer") }
  before { wrapper.configure(converter: converter, formatter: formatter, syncer: syncer, renderer: renderer) }

  describe "#update" do
    before do
      converter.stub(:convert)
      formatter.stub(:format)
      syncer.stub(:sync)
      renderer.stub(:render)
    end

    it "tells the converter to convert" do
      converter.should_receive(:convert)
      wrapper.update(nil)
    end

    it "tells the formatter to format" do
      formatter.should_receive(:format)
      wrapper.update(nil)
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
