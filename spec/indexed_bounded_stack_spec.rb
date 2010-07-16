require 'spec_helper'

describe IndexedBoundedStack do
  before do
    @indexed_stack = IndexedBoundedStack.new(BoundedStack.new(LinkedList.new, 5))
  end

  describe "#push" do
    it "adds items" do
      @indexed_stack.push(1)
      @indexed_stack.push(2)
      @indexed_stack.to_a.should == [1, 2]
    end

    it "returns items that were shifted off" do
      5.times do |i|
        @indexed_stack.push(i + 1)
      end
      node, shifted = @indexed_stack.push(6)
      shifted.should == 1
    end
  end

  describe "#delete" do
    it "moves an item if it exists" do
      @indexed_stack.push(1)
      @indexed_stack.push(2)
      @indexed_stack.delete(2)
      @indexed_stack.to_a.should == [1]
      @indexed_stack.push(2)
      @indexed_stack.to_a.should == [1, 2]
    end
  end

  describe "#include?" do
    it "moves an item if it exists" do
      @indexed_stack.push(1)
      @indexed_stack.push(2)
      @indexed_stack.include?(2).should be_true
      @indexed_stack.include?(3).should be_false
    end
  end
end
