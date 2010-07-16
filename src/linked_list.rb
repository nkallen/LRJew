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
