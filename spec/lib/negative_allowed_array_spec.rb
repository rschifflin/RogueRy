require 'spec_helper'

describe NegativeAllowedArray do
  subject(:naa) { NegativeAllowedArray.new }
  it "allows positive reads" do
    expect(naa[6]).to eq nil
  end
  
  it "allows negative reads" do
    expect(naa[-16]).to eq nil
  end

  it "allows positive writes" do
    naa[12] = :foo
    expect(naa[12]).to eq :foo
  end

  it "allows negative write" do
    naa[-15] = :bar
    expect(naa[-15]).to eq :bar
  end

  it "allows a combination of negative and positive writes" do
    naa[27] = :foo
    naa[-105] = :bar
    expect(naa[27]).to eq :foo
    expect(naa[-105]).to eq :bar
  end

end
