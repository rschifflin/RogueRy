require 'spec_helper'

describe Entity do
  subject(:entity) { Entity.new(world: world, log: log) }
  let(:world) { double "World" }
  let(:log) { double "Log" }
  before { log.stub(:log) }

  describe("#move_north") do
    it "sends a command to the world to move itself north" do
      world.should_receive(:move_north).with(entity)
      entity.move_north
    end

    context "on success" do
      before { world.stub(:move_north) { true } }
      it "logs a successful statement" do
        log.should_receive(:log).with("You moved north!")
        entity.move_north
      end
    end
    context "on failure" do
      before { world.stub(:move_north) { false } }
      it "logs a successful statement" do
        log.should_receive(:log).with("You can't move north!")
        entity.move_north
      end
    end
  end 
  describe("#move_south") do
    it "sends a command to the world to move itself south" do
      world.should_receive(:move_south).with(entity)
      entity.move_south
    end
    context "on success" do
      before { world.stub(:move_south) { true } }
      it "logs a successful statement" do
        log.should_receive(:log).with("You moved south!")
        entity.move_south
      end
    end
    context "on failure" do
      before { world.stub(:move_south) { false } }
      it "logs a successful statement" do
        log.should_receive(:log).with("You can't move south!")
        entity.move_south
      end
    end
  end 
  describe("#move_east") do
    it "sends a command to the world to move itself east" do
      world.should_receive(:move_east).with(entity)
      entity.move_east
    end
    context "on success" do
      before { world.stub(:move_east) { true } }
      it "logs a successful statement" do
        log.should_receive(:log).with("You moved east!")
        entity.move_east
      end
    end
    context "on failure" do
      before { world.stub(:move_east) { false } }
      it "logs a successful statement" do
        log.should_receive(:log).with("You can't move east!")
        entity.move_east
      end
    end
  end 
  describe("#move_west") do
    it "sends a command to the world to move itself west" do
      world.should_receive(:move_west).with(entity)
      entity.move_west
    end
    context "on success" do
      before { world.stub(:move_west) { true } }
      it "logs a successful statement" do
        log.should_receive(:log).with("You moved west!")
        entity.move_west
      end
    end
    context "on failure" do
      before { world.stub(:move_west) { false } }
      it "logs a successful statement" do
        log.should_receive(:log).with("You can't move west!")
        entity.move_west
      end
    end
  end 
end
