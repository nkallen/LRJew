class LinkedList
  include Enumerable

  def initialize
    @last = Node.new(nil, nil)
    @first = Node.new(nil, @last)
    @last.prev = @first
  end

  def push(data)
    case data
    when Node
      insert_before(@first.next, data)
    else
      node = @first.next.push(data)
      @first.next = node
      node.prev = @first
      node
    end
  end

  def each
    node = @last
    while (node = node.prev) && node.data
      yield node.data
    end
  end

  def delete(node)
    node.prev.next = node.next
    node.next.prev = node.prev
    node.data
  end

  def insert_before(before, after)
    after.prev.next = before
    before.next = after
    before.prev = after.prev
    after.prev = before
  end

  def shift
    delete(@last.prev) unless @last.prev == @first
  end

  def length
    @first.next.length
  end

  alias_method :size, :length
end

class Node
  attr_accessor :next, :prev
  attr_reader :data

  def initialize(data, _next)
    @data = data
    @next = _next
  end

  def length
    if @data.nil?
      0
    else
      1 + @next.length
    end
  end

  def push(data)
    node = Node.new(data, self)
    self.prev = node
    node
  end

  def inspect
    prev_data = @prev && @prev.data || nil
    next_data = @next && @next.data || nil
    "#{prev_data.inspect} <- #{@data.inspect} -> #{next_data.inspect}"
  end
  alias_method :to_s, :inspect
end


# Here we include
require 'rubygems'
require 'spec'

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
