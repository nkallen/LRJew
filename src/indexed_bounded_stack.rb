require 'bounded_stack'
require 'linked_list'

class IndexedBoundedStack
  include Enumerable

  def initialize(bounded_stack)
    @bounded_stack = bounded_stack
    @index = {}
  end

  def include?(data)
    @index.has_key?(data)
  end

  def push(data)
    node, shifted = @bounded_stack.push(data)
    @index[data] = node
    if shifted
      @index.delete(shifted.data)
    end
  end

  def delete(data)
    if node = @index[data]
      @bounded_stack.delete(node)
      @index.delete(data)
    end
  end

  def length
    @indices.length
  end

  alias_method :size, :length

  def each(&block)
    @bounded_stack.each(&block)
  end
end

require 'rubygems'
require 'spec'

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
