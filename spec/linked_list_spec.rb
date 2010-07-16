require 'spec_helper'

describe LinkedList do
  before do
    @linked_list = LinkedList.new
  end

  describe "#push" do
    it "lets you push on multiple values" do
      @linked_list.push(1)
      @linked_list.push(2)
      @linked_list.push(3)
      @linked_list.to_a.should == [1, 2, 3]
    end
  end

  describe "#delete" do
    it "lets you remove an element in the middle" do
      one = @linked_list.push(1)
      two = @linked_list.push(2)
      three = @linked_list.push(3)
      @linked_list.delete(two)
      @linked_list.to_a.should == [1, 3]
    end

    it "lets you remove the head" do
      one = @linked_list.push(1)
      two = @linked_list.push(2)
      three = @linked_list.push(3)

      @linked_list.delete(one)
      @linked_list.to_a.should == [2, 3]
    end

    it "lets you remove the last" do
      one = @linked_list.push(1)
      two = @linked_list.push(2)
      three = @linked_list.push(3)

      @linked_list.delete(three)
      @linked_list.to_a.should == [1, 2]
    end
  end

  describe "#shift" do
    it "removes the last item" do
      @linked_list.push(1)
      @linked_list.push(2)
      @linked_list.push(3)

      @linked_list.shift.should == 1
      @linked_list.to_a.should == [2, 3]
    end

    it "removes from a list with one item" do
      @linked_list.push(1)
      @linked_list.shift.should == 1
      @linked_list.to_a.should == []
    end

    it "shifting an empty list does nothing" do
      @linked_list.shift.should == nil
      @linked_list.to_a.should == []
    end
  end

  describe "#length" do
    it "is zero for the empty list" do
      @linked_list.length.should == 0
    end

    it "returns the number of items in the list" do
      @linked_list.push(1)
      @linked_list.push(2)
      @linked_list.length.should == 2
    end

    it "returns the number of items in the list even after a delete" do
      @linked_list.push(1)
      two = @linked_list.push(2)
      @linked_list.push(3)
      @linked_list.delete(two)
      @linked_list.length.should == 2
    end

    it "returns zero when you remove all items" do
      one = @linked_list.push(1)
      @linked_list.delete(one)
      @linked_list.length.should == 0
    end
  end
end
