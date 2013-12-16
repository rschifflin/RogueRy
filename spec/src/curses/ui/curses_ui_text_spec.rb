require 'spec_helper'

describe CursesUIText do
  subject(:text) { CursesUIText.new(ui_text) }
  let(:ui_text) { UIText.new(ui_parent, "") }
  let(:ui_parent) { UIElement.new.resize(50,50) }

  let(:output) { ["." * 80] }
  describe "#render" do
    context "with text length 43" do
      before do 
        ui_text.text = "The quick brown fox jumps over the lazy dog" 
        text.update_from(ui_text)
      end

      it "renders" do
        full_text_result = ["The quick brown fox jumps over the lazy dog" + ("." * 37)]
        expect(text.render output).to eq full_text_result
      end
    end
  end
end
