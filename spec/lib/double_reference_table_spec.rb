require 'spec_helper'

describe DoubleReferenceTable do
  let(:drt) { DoubleReferenceTable.new }
  describe "#insert" do
    context "With a new, unique item" do
      let(:item) { double("Item") }

      context "When given 2d indices" do
        let(:indices) { [3, 7] }
        it "inserts the item at those indices" do
          expect { drt.insert(*indices, item) }.to change { drt.size }.by 1
        end 
        it "hashes the item to the indices" do
          drt.insert(*indices, item)
          expect(drt.find(item)).to eq indices
        end

        it "returns the item on success" do
          expect(drt.insert(*indices, item)).to eq item
        end
      end
    end

    context "With an item already in the index" do
      let(:item) { double("Item") }
      before { drt.insert(0, 0, item) }
      it "returns false on failure" do
        expect(drt.insert(0,0,item)).to eq false
      end
      it "doesn't insert the item" do
        expect{ drt.insert(0,0,item) }.not_to change { drt.size }
      end
    end

    context "inserting two different items to the same index" do
      let(:old_boot) { double("Item") }
      let(:empty_bottle) { double("Item") }
      before do 
        drt.insert(0, 0, old_boot) 
        drt.insert(0, 0, empty_bottle) 
      end
      it "Inserts both without issue" do
        expect(drt.size).to eq 2
      end
      it "Gives the same indices to both" do
        expect(drt.find(old_boot)).to eq drt.find(empty_bottle)
      end
    end
  end

  describe "#delete" do
    context "With an item already in the index" do
      let(:item) { double("Item") }
      before { drt.insert(6, 8, item) }
      it "removes the item from the index" do
        expect { drt.delete(item) }.to change { drt.size }.by(-1)
      end

      it "returns the removed item" do
        expect(drt.delete(item)).to eq item
      end
    end

    context "With an item not already in the index" do
      let(:item) { double("Item") }
      it "Doesn't remove anything" do
        expect { drt.delete(item) }.to_not change { drt.size }
      end

      it "returns false" do
        expect(drt.delete(item)).to eq false
      end
    end
  end

  describe "#find" do
    let(:item) { double('Item') }
    context "With the item ready to be found" do
      before { drt.insert(1, 12, item) }
      it "returns the coordinates" do
        expect(drt.find(item)).to eq [1,12]
      end 
    end

    context "Without the item" do
      it "returns nil" do
        expect(drt.find(item)).to eq nil
      end
    end
  end

  describe "#at" do
    context "With an item ready to be found" do
      let(:item) { double('Item') }
      before { drt.insert(5, 10, item) }

      context "With the correct indices" do
        let(:arg) { [5,10] }
        it "returns a collection containing the item" do
          expect(drt.at(*arg)).to include item
        end
      end

      context "With multiple items at the index" do
        let(:arg) { [5,10] }
        let(:expected_array) { [item, :tin_can, :copper_coin] }
        before do 
          drt.insert(5, 10, :tin_can) 
          drt.insert(5, 10, :copper_coin)
        end
        it "returns a collection containing all the items" do
          expect(drt.at(*arg)).to match_array expected_array
        end
      end

      context "With incorrect indices" do
        let(:arg) { [8,0] }
        it "returns an empty collection" do
          expect(drt.at(*arg)).to eq []
        end
      end
    end

    context "With the item not in the index" do
      it "returns an empty collection" do
        expect(drt.at(3,9)).to eq []
      end
    end
  end
end
