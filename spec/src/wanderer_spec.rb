require 'spec_helper'

describe Wanderer do
  subject(:wanderer) { Wanderer.new(0,0) }

  describe "#left" do
    before { subject.left() }
    it { expect(subject.pos).to eq([-1,0]) }
  end
  describe "#right" do
    before { subject.right() }
    it { expect(subject.pos).to eq([1,0]) }
  end
  describe "#up" do
    before { subject.up() }
    it { expect(subject.pos).to eq([0,-1]) }
  end
  describe "#down" do
    before { subject.down() }
    it { expect(subject.pos).to eq([0,1]) }
  end

end
