require 'spec_helper'

describe SimpleTree do
  subject(:root) { SimpleTree.new }

  context "with a root with three children" do
    let(:child_a) { SimpleTree.new.tap { |t| t.parent = root } }
    let(:child_b) { SimpleTree.new.tap { |t| t.parent = root } }
    let(:child_c) { SimpleTree.new.tap { |t| t.parent = root } }

    context "when calling each on the root" do
      it "calls the block for itself and each child" do
        root.should_receive(:block_msg)
        child_a.should_receive(:block_msg)
        child_b.should_receive(:block_msg)
        child_c.should_receive(:block_msg)
        root.each(&:block_msg)
      end 
    end

    describe "moving a child" do
      context "when moving child_c from under root to under child_a" do
        before { child_c.parent = child_a }
        it "updates its parent to child_a" do
          expect(child_c.parent).to eq child_a
        end

        it "Stays as a child (now grandchild) of root" do
          expect(root.child?(child_c)).to be_true
        end

        it "Adds the child to child_a" do
          expect(child_a.child?(child_c)).to be_true
        end
      end
    end

    describe "removing a child" do
      it "returns nil if the child wasn't found" do
        expect(root.remove_child "child_d").to be_nil
      end

      it "returns the removed child if found" do
        expect(root.remove_child child_a).to eq child_a
      end

      it "no longer iterates over the removed child" do
        child_c.should_not_receive(:nil?)
        root.remove_child child_c
        root.each(&:nil?)
      end
    end
  end 

  context "With a linear chain of children" do
    let(:child_a) { SimpleTree.new.tap { |t| t.parent = root } }
    let(:child_b) { SimpleTree.new.tap { |t| t.parent = child_a } }
    let(:child_c) { SimpleTree.new.tap { |t| t.parent = child_b } }

    context "when calling each on the root" do
      it "calls the block for itself and each child" do
        root.should_receive(:block_msg)
        child_a.should_receive(:block_msg)
        child_b.should_receive(:block_msg)
        child_c.should_receive(:block_msg)
        root.each(&:block_msg)
      end 
    end

    describe "adding a child" do
      let(:child_d) { SimpleTree.new.with_parent(:child_b) }
    end

    describe "moving a child" do
      context "when moving child_c from under child_b to under root" do
        before { child_c.parent = root }
        it "updates its parent to root" do
          expect(child_c.parent).to eq root
        end

        it "Adds the child to root" do
          expect(root.child?(child_c)).to be_true
        end

        it "Removes the child from child_b" do
          expect(child_b.child?(child_c)).to be_false
        end
      end
    end

    describe "removing a child" do
      it "returns nil if the child wasn't found" do
        expect(root.remove_child "child_d").to be_nil
      end

      it "returns the removed child if true" do
        expect(root.remove_child child_c).to eq child_c
      end

      it "no longer iterates over the removed child" do
        child_c.should_not_receive(:nil?)
        root.remove_child child_c
        root.each(&:nil?)
      end
    end
  end 
end
