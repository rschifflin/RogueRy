require 'spec_helper'

describe SpatialIndex do
  subject(:spatial_index) { SpatialIndex.new }
  it "Can index positive indices" do
    spatial_index[5][3] = :foo
    expect(spatial_index[5][3]).to eq :foo
  end

  it "Can index negative indices" do
    spatial_index[-10][-153] = :foo
    expect(spatial_index[-10][-153]).to eq :foo
  end

  it "Can index negative/positive indices" do
    spatial_index[-22][41] = :foo
    expect(spatial_index[-22][41]).to eq :foo
  end

  it "Can index positive/negative indices" do
    spatial_index[312][-2] = :foo
    expect(spatial_index[312][-2]).to eq :foo
  end

  it "Can write various indices, then read them back" do
    spatial_index[100][101] = :foo
    spatial_index[-15][242] = :bar
    spatial_index[0][0] = :baz
    expect(spatial_index[100][101]).to eq :foo
    expect(spatial_index[-15][242]).to eq :bar
    expect(spatial_index[0][0]).to eq :baz
  end

  it "can iterate" do
    spatial_index[17][99] = :baz
    spatial_index[17][-51]
    spatial_index[0][3] = :bar
    spatial_index[-5][-8] = :foo
    spatial_index[3][3]
    expect { |b| spatial_index.each(&b) }.to yield_successive_args(:foo, :bar, :baz)
  end

  it "can iterate with indices" do
    spatial_index[17][99] = :baz
    spatial_index[17][-51]
    spatial_index[0][3] = :bar
    spatial_index[-5][-8] = :foo
    spatial_index[3][3]
    result = []
    spatial_index.each_with_indices do |obj, x, y|
      result << [obj, x, y]
    end
    expect(result).to eq [[:foo, -5, -8], [:bar, 0, 3], [:baz, 17, 99]]
  end

end
