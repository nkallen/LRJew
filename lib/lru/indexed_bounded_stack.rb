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

