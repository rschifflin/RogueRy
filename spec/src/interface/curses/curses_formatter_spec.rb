require 'spec_helper'

describe CursesFormatter do
  subject(:formatter) { CursesFormatter.new }

  describe "Formatting tags" do
    let(:view) { double(:View) }
    before { view.stub(:[]=) }

    describe "#format_tag_title" do
      it "Sets the view alignment to center" do
        view.should_receive(:move).with(10,1)
        formatter.format_tag_title(view)
      end
    end

    describe "#format_tag_bg_light" do
      it "Sets the bg symbol as ." do
        view.should_receive(:background=).with(?.)
        formatter.format_tag_bg_light(view)
      end
    end

    describe "#format_tag_body" do
      it "Sets the view alignment to center" do
        view.should_receive(:move).with(5,5)
        formatter.format_tag_body(view)
      end
    end
  end
end
