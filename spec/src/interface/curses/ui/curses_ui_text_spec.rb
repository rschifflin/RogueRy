require 'spec_helper'

describe CursesUIText do
  subject(:text) { CursesUIText.new(ui_text) }
  let(:ui_text) { UIText.new("") }
  let(:ui_parent) { UIElement.new.resize(100,100).add_child(ui_text) }
  let(:output) { [" " * 80] }
  describe "#render" do
    context "with no text overflow" do
      context "with a bounding box of 50x50" do
        before do 
          ui_text.resize(50,50)
        end
        context "with text length 43" do
          before do 
            ui_text.text = "The quick brown fox jumps over the lazy dog" 
          end

          it "fits the full text with 37 characters to spare" do
            full_text_result = ["The quick brown fox jumps over the lazy dog" + (" " * 37)]
            expect(text.render output).to eq full_text_result
          end
        end
        context "with text length 88" do
          before do 
            ui_text.text = "The quick brown fox jumps over the lazy dog. The quick brown fox jumps over the lazy dog" 
          end

          it "fits only the first 50 characters of the text" do
            full_text_result = ["The quick brown fox jumps over the lazy dog. The quick brown fox jumps over the lazy dog".slice(0,50) + (" " * 30)]
            expect(text.render output).to eq full_text_result
          end
        end
      end
    end

    context "with text overflow 'truncate'" do
      before do 
        ui_text[:overflow] = :truncate
      end

      context "with a bounding box of 50x50" do
        before do 
          ui_text.resize(50,50)
        end

        context "with text length 50" do
          before do 
            ui_text.text = "The clever burgundy fox jumps over a very lazy dog"
          end

          it "fits the full text with 30 characters to spare" do
            full_text_result = ["The clever burgundy fox jumps over a very lazy dog" + (" " * 30)]
            expect(text.render output).to eq full_text_result
          end
        end
        context "with text length 51" do
          before do 
            ui_text.text = "The clever burgundy fox jumps above the laziest dog" 
          end

          it "fits only the first 47 characters of the text, and pads the end with ..." do
            full_text_result = ["The clever burgundy fox jumps above the laziest dog".slice(0,47) + "..." + (" " * 30)]
            expect(text.render output).to eq full_text_result
          end
        end
      end
    end
  end
end
