require 'spec_helper'

describe BoundedStack do
  before do
    @bounded_stack = BoundedStack.new([], 5)
  end

  describe "#push" do
    describe "when the stack is not full" do
      it "increments the size" do
        @bounded_stack.push(1)
        @bounded_stack.push(2)
        @bounded_stack.size.should == 2
        @bounded_stack.to_a.should == [1, 2]
      end
    end

    describe "when the stack is full" do
      it "truncates the list" do
        5.times do |i|
          @bounded_stack.push(i + 1)
        end
        @bounded_stack.push(6)[1].should == 1
        @bounded_stack.size.should == 5
        @bounded_stack.to_a.should == [2, 3, 4, 5, 6]
      end
    end
  end

  describe '#delete' do
    it "decrements the size" do
      @bounded_stack.push(1)
      @bounded_stack.push(2)
      @bounded_stack.size.should == 2
      @bounded_stack.delete(2)
      @bounded_stack.size.should == 1
    end
  end
end
