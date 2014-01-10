require 'spec_helper'

class Tagger; include Taggable; end
describe Taggable do
  subject(:taggable) { Tagger.new }

  it "Allows arbitrary tags to be added" do
    taggable.add_tag(:some_key)
    expect(taggable.tags).to include :some_key
  end

  it "Doesn't allow duplicate tags" do
    taggable.add_tag(:some_key)
    taggable.add_tag(:some_key)
    expect(taggable.tags.size).to eq 1
  end
end
