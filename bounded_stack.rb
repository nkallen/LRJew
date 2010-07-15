class BoundedStack
  include Enumerable

  def initialize(list, maximum_size)
    @list = list
    @maximum_size = maximum_size
    @current_size = list.length
    raise ArgumentError unless @current_size <= @maximum_size
  end

  def push(data)
    shifted = nil
    if @current_size == @maximum_size
      shifted = @list.shift
    else
      @current_size += 1
    end

    node = @list.push(data)
    [node, shifted]
  end

  def length
    @current_size
  end

  alias_method :size, :length

  def method_missing(method, *args, &block)
    @list.send(method, *args, &block)
  end

  def each(&block)
    @list.each(&block)
  end
end

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
        5.times do |i|
          @bounded_stack.push(i + 1)
        end
        @bounded_stack.push(6)[1].should == 1
        @bounded_stack.size.should == 5
        @bounded_stack.to_a.should == [2, 3, 4, 5, 6]
      end
    end
  end
end
