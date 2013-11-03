require 'spec_helper'

describe Floor do
  subject(:floor) { Floor.new }

  describe "#insert and #at" do
    it "sets and retrieves an object given indices" do
      floor_object = Object.new
      floor.insert(floor_object, 5, 12)
      expect(floor[5,12]).to eq Set[floor_object]
    end

    context "With multiple objects at the same indices" do
      it "returns the list of objects sharing the indices" do
        objects = [Object.new, Object.new, Object.new]
        floor.insert(objects[0], 3, 5)
        floor.insert(objects[1], 3, 5)
        floor.insert(objects[2], 3, 5)
        expect(floor[3,5]).to eq Set[*objects]
      end
    end

  end
end

