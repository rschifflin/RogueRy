require 'spec_helper'

class HeirarchyMemberObject
  include HeirarchyMember
  def initialize(name)
    @name = name
  end
  def to_s
    @name
  end
end

describe HeirarchyMember do
  let(:obj_a) { HeirarchyMemberObject.new("A") }
  let(:obj_b) { HeirarchyMemberObject.new("B") }
  let(:obj_c) { HeirarchyMemberObject.new("C") }
  let(:obj_d) { HeirarchyMemberObject.new("D") }
  let(:obj_e) { HeirarchyMemberObject.new("E") }
  let(:obj_f) { HeirarchyMemberObject.new("F") }
  let(:obj_g) { HeirarchyMemberObject.new("G") }

  describe "#add_child" do
    it "adds the child" do
      obj_a.add_child obj_b
      expect(obj_a.children).to include(obj_b)
    end
    it "increases the child count" do
      expect{ obj_a.add_child obj_b }.to change{ obj_a.children.size }.by(1)
    end
  end

  describe "#remove_child" do
    before { obj_a.add_children(obj_b, obj_c) }
    it "removes the child" do
      obj_a.remove_child obj_b
      expect(obj_a.children).to_not include(obj_b)
    end
    it "reduces the child count if found" do
      expect{ obj_a.remove_child obj_b }.to change{ obj_a.children.size }.by(-1)
    end
    it "doesn't reduce the child count if not found" do
      expect{ obj_a.remove_child obj_d }.to_not change{ obj_a.children.size }.by(-1)
    end
  end

  describe "#remove_all_children" do
    before { obj_a.add_children(obj_b, obj_c) }
    it "removes both children" do
      obj_a.remove_all_children
      expect(obj_a.children).to_not include(obj_b, obj_c)
    end
    it "reduces the child count to 0" do
      expect{ obj_a.remove_all_children }.to change{ obj_a.children.size }.to(0)
    end
  end
  
  describe "#on_parent_added" do
    it "gets fired when a parent adds a child" do
      obj_b.should_receive(:on_parent_added).with(obj_a)
      obj_a.add_child obj_b
    end
  end

  describe "#on_parent_removed" do
    before { obj_a.add_children(obj_b, obj_c) }
    it "gets fired when a parent removes a child" do
      obj_b.should_receive(:on_parent_removed).with(obj_a)
      obj_a.remove_child obj_b
    end

    it "gets fired when a parent removes all children" do
      obj_b.should_receive(:on_parent_removed).with(obj_a)
      obj_c.should_receive(:on_parent_removed).with(obj_a)
      obj_a.remove_all_children
    end
  end

  describe "traversal" do
    context "With no nesting" do
      it { expect(obj_a.inject(""){ |str, member| str + member.to_s }).to eql("A") }
    end

    context "With C nested in B nested in A" do
      before { obj_a.add_child obj_b; obj_b.add_child obj_c }
      it "traverses by default pre order" do
        expect(obj_a.inject(""){ |str, member| str + member.to_s }).to eql("ABC")
      end
      it "traverses pre order when specified" do
        expect(obj_a.visit_in(:preorder).inject(""){ |str, member| str + member.to_s }).to eql("ABC")
      end
      it "traverses post order when specified" do
        expect(obj_a.visit_in(:postorder).inject(""){ |str, member| str + member.to_s }).to eql("CBA")
      end
    end

    context "With a full binary tree, from root to leaves as A, BC, DE, FG" do
      before do 
        obj_a.add_children(obj_b, obj_c)
        obj_b.add_children(obj_d, obj_e)
        obj_c.add_children(obj_f, obj_g)
      end
      it "traverses by default pre order" do
        expect(obj_a.inject(""){ |str, member| str + member.to_s }).to eql("ABDECFG")
      end
      it "traverses pre order when specified" do
        expect(obj_a.visit_in(:preorder).inject(""){ |str, member| str + member.to_s }).to eql("ABDECFG")
      end
      it "traverses post order when specified" do
        expect(obj_a.visit_in(:postorder).inject(""){ |str, member| str + member.to_s }).to eql("DEBFGCA")
      end
    end
  end
end
