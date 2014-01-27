require 'spec_helper'

describe World do
  subject(:world) { World.new }
  describe "#spawn" do
    let(:entity) { double "Entity" }
    it "creates the given object at the given world coordinates" do
      world.spawn(entity, 4, 12)
      expect(world.at(4,12)).to include entity
    end
  end

  describe "#move_north" do
    let(:entity) { double "Entity" }
    context "With an entity not in the world" do
      it "returns false" do
        expect(world.move_north(entity)).to eq false
      end
    end
    context "With an entity that does exist" do
      before { world.spawn(entity) }
      context "Where moving north is legal" do
        it "returns true" do
          expect(world.move_north(entity)).to eq true
        end
        it "removes the item from its old spot" do
          expect{ world.move_north(entity) }.to change { world[0,0] }.to []
        end
        it "updates the entity's position to y+1" do
          expect{ world.move_north(entity) }.to change { world[0,1] }.to [entity]
        end
      end
    end
  end
end
