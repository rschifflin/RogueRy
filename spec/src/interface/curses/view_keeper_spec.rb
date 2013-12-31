require 'spec_helper'

describe CursesViewKeeper do
  subject(:view_keeper) { CursesViewKeeper.new(view_converter) }
  let(:view_converter) { CursesViewConverter.new }

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

  describe "#sync" do
    context "with no existing views" do
      context "and no incoming views" do
        let(:agnostic_views) { [] }
        it "creates nothing" do
          view_keeper.sync(agnostic_views)
          expect(view_keeper.views.count).to be_zero
        end
      end

      context "and an incoming view" do
        class MockViewConverter
          def convert view
          end
        end

        let(:agnostic_views) { [double("AgnosticView")] } 
        let(:converted_view) { double("ConvertedView") }
        let(:view_converter) { double("ViewConverter") }
        before { view_converter.stub(:convert) { converted_view } }

        it "creates a new view heirarchy using the provided engine view" do
          view_keeper.sync(agnostic_views)
          expect(view_keeper.views.count).to eq 1
          expect(view_keeper.views.first).to eq converted_view
        end
      end
    end
  end

end
