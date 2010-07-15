class BoundedStack
  include Enumerable

  def initialize(list, maximum_size)
    @list = list
    @maximum_size = maximum_size
    @current_size = list.length
    raise ArgumentError unless @current_size <= @maximum_size
  end

  def push(data)
    if @current_size == @maximum_size
      @list.shift
    else
      @current_size += 1
    end

    @list.push(data)
  end

  def length
    @current_size
  end

  alias_method :size, :length

  def each(&block)
    @list.each(&block)
  end
end

class Node
  attr_accessor :next, :prev
  attr_reader :data

  def initialize(data, _next)
    @data = data
    @next = _next
  end

  def push(data)
    node = Node.new(data, self)
    self.prev = node
    node
  end

  def inspect
    prev_data = @prev && @prev.data || nil
    next_data = @next && @next.data || nil
    "#{@prev_data.inspect} <- #{@data.inspect} -> #{@next_data.inspect}"
  end
  alias_method :to_s, :inspect
end


# Here we include
require 'rubygems'
require 'spec'

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
        6.times do |i|
          @bounded_stack.push(i + 1)
        end
        @bounded_stack.size.should == 5
        @bounded_stack.to_a.should == [2, 3, 4, 5, 6]
      end
    end
  end
end
