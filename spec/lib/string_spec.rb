require 'spec_helper'

describe String do
  describe "#to_snake" do
    context "With an empty string" do
      it { expect("".to_snake).to eq "" }
    end
    context "With a single word lowercase string" do
      it { expect("martini".to_snake).to eq "martini" }
    end
    context "With a single word uppercase string" do
      it { expect("Tractor".to_snake).to eq "tractor" }
    end
    context "With a single word multicase string" do
      it { expect("AlreadyCamelAlready".to_snake).to eq "already_camel_already" }
    end
    context "With a multi-word lowercase string" do
      it { expect("red car".to_snake).to eq "red_car" }
    end
    context "With a multi-word mixed case string" do
      it { expect("Buy oNe haT".to_snake).to eq "buy_o_ne_ha_t" }
    end
    context "With a multi-word snake case string" do
      it { expect("real_deal".to_snake).to eq "real_deal" }
    end
    context "with a multi-word mixed snake and space string" do
      it { expect("Up_tempo offense".to_snake).to eq "up_tempo_offense" }
    end
    context "with trailing whitespace" do
      it { expect("Here lies Bob   ".to_snake).to eq "here_lies_bob" }
    end
    context "with leading whitespace" do
      it { expect("   Bob lies here".to_snake).to eq "bob_lies_here" }
    end
    context "with consecutive delimiters" do
      it { expect("We---come_____in peace".to_snake).to eq "we_come_in_peace" }
    end
    context "with consecutive mixed delimiters" do
      it { expect(" -_please-_ -do- - - investigate__  ".to_snake).to eq "please_do_investigate" }
    end
    context "with consecutive mixed delimiters and capitals" do
      it { expect("--EveryGood  _  Boy  -___does--fine".to_snake).to eq "every_good_boy_does_fine" }
    end
    context "with consecutive capitals" do
      it { expect("ICABlueBird".to_snake).to eq "i_c_a_blue_bird" }
    end
  end

  describe "#to_camel" do
    context "With an empty string" do
      it { expect("".to_camel).to eq "" }
    end
    context "With a single word lowercase string" do
      it { expect("martini".to_camel).to eq "Martini" }
    end
    context "With a single word uppercase string" do
      it { expect("Tractor".to_camel).to eq "Tractor" }
    end
    context "With a single word multicase string" do
      it { expect("AlreadyCamelAlready".to_camel).to eq "AlreadyCamelAlready" }
    end
    context "With a multi-word lowercase string" do
      it { expect("red car".to_camel).to eq "RedCar" }
    end
    context "With a multi-word mixed case string" do
      it { expect("Buy oNe haT".to_camel).to eq "BuyONeHaT" }
    end
    context "With a multi-word snake case string" do
      it { expect("real_deal".to_camel).to eq "RealDeal" }
    end
    context "with a multi-word mixed snake and space string" do
      it { expect("Up_tempo offense".to_camel).to eq "UpTempoOffense" }
    end
    context "with trailing whitespace" do
      it { expect("Here lies Bob   ".to_camel).to eq "HereLiesBob" }
    end
    context "with leading whitespace" do
      it { expect("   Bob lies here".to_camel).to eq "BobLiesHere" }
    end
    context "with consecutive delimiters" do
      it { expect("We---come_____in peace".to_camel).to eq "WeComeInPeace" }
    end
    context "with consecutive mixed delimiters" do
      it { expect(" -_please-_ -do- - - investigate__  ".to_camel).to eq "PleaseDoInvestigate" }
    end
  end

  describe "#merge" do
    context "With string A < string B" do
      let(:string_a) { "String A" }
      let(:string_b) { "String B plus some" }
      context "Using no index" do
        it { expect(string_a.merge string_b).to eq "String B" }
      end

      context "With index 5" do
        it { expect(string_a.merge string_b, 5).to eq "StrinStr" }
      end

      context "With index 1293" do
        it "raises an IndexError" do
          expect { string_a.merge string_b, 1239 }.to raise_error IndexError
        end
      end
    end

    context "With string A == string B" do
      let(:string_a) { "abcdef" }
      let(:string_b) { "123456" }
      context "Using no index" do
        it { expect(string_a.merge string_b).to eq "123456" }
      end

      context "With index 4" do
        it { expect(string_a.merge string_b, 4).to eq "abcd12" }
      end

      context "With index 123" do
        it "raises an IndexError" do
          expect { string_a.merge string_b, 123 }.to raise_error IndexError
        end
      end
    end

    context "With string A > string B" do
      let(:string_a) { "String A plus some" }
      let(:string_b) { "String B" }
      context "Using no index" do
        it { expect(string_a.merge string_b).to eq "String B plus some" }
      end

      context "With index 3" do
        it { expect(string_a.merge string_b, 3).to eq "StrString Bus some" }
      end

      context "With using string_a's length as index" do
        it { expect(string_a.merge string_b, string_a.length).to eq "String A plus some" }
      end

      context "With index 555" do
        it "raises an IndexError" do
          expect { string_a.merge string_b, 555 }.to raise_error IndexError
        end
      end
    end
  end
end
