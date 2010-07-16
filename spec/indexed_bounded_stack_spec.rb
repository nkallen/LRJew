require 'rubygems'
require 'spec'
require '../src/indexed_bounded_stack'

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
