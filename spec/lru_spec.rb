require 'spec_helper'

describe Lru do
  before do
    @lru = Lru.new(IndexedBoundedStack.new(BoundedStack.new(LinkedList.new, 5)))
  end

  describe "#include?" do
    it "hits go up as we check inclusion of items that exist" do
      @lru.include?(1)
      @lru.misses.should == 1
      @lru.hits.should == 0

      @lru.include?(1)
      @lru.misses.should == 1
      @lru.hits.should == 1
    end

    it "increments evictions as the stack fills up" do
      5.times do |i|
        @lru.include?(i + 1)
      end
      @lru.evictions.should == 0
      @lru.include?(6)
      @lru.evictions.should == 1
    end
  end
end
