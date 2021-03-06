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

  def delete(data)
    @list.delete(data)
    @current_size -= 1
  end

  def length
    @current_size
  end
  alias_method :size, :length


  def each(&block)
    @list.each(&block)
  end
end
