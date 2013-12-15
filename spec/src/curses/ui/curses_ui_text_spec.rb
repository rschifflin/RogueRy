require 'spec_helper'

describe CursesUIText do
  subject(:text) { UIText.new(0,0,0,0,parent, "") }
  let(:parent) { UIElement.new(0,0,50,50) }

  let(:output) { ["." * 80] }
  describe "#render" do
    context "with text length 43" do
      before { text.text = "The quick brown fox jumps over the lazy dog" }
      it "renders" do
        full_text_result = ["The quick brown fox jumps over the lazy dog" + ("." * 37)]
        expect(text.render output).to eq full_text_result
      end
    end
  end
end
