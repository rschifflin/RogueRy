require 'spec_helper'

describe Surroundings do
  subject(:surroundings) { Surroundings.new }
  context 'with some surroundings' do
    before do
      5.times do |i|
        5.times do |j|
          surroundings[i-2,j-2] << "Index (#{i-2},#{j-2})"
        end
      end
    end
    it "allows arbitrary 2d indexing" do
      expect(surroundings[2, -1]).to include "Index (2,-1)"
      expect(surroundings[5, 15]).to eq []
    end
  end
  context 'with no surroundings' do
    describe '#origin'  do
      it 'returns 0,0' do
        expect(surroundings.origin).to eq [0,0]
      end
    end
  end

  describe "#append" do
    let(:lhs) { Surroundings.new }
    let(:rhs) { Surroundings.new }
    before do
      rhs.origin = [-2, 2]

      5.times do |i|
        5.times do |j|
          lhs[i,j] << :lhs
        end
      end
      7.times do |i|
        4.times do |j|
          rhs[i-3,j] << :rhs
        end
      end
    end

    it "appends to the current surroundings, then updates the origin using the rhs" do
      lhs.append(rhs)
      expect(lhs.origin).to eq rhs.origin
    end

    it "offsets and adds any non-overlapping indices from the lhs" do
    end

  end
end
