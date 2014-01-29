require 'spec_helper'

describe Surroundings do
  subject(:surroundings) { Surroundings.new }
  context 'with no surroundings' do
    describe '#origin'  do
      it 'returns nil' do
        expect(surroundings.origin).to eq nil
      end
    end
  end
end
