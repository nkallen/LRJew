class Lru
  include Enumerable
  attr_reader :evictions, :hits, :misses, :gets

  def initialize(indexed_bounded_stack)
    @stack = indexed_bounded_stack
    @gets = @hits = @misses = @evictions = 0
  end

  def include?(item)
    @gets += 1
    if included = @stack.include?(item)
      @hits += 1
      @stack.delete(item)
      @stack.push(item)
    else
      @misses += 1
      _, shifted = @stack.push(item)
      @evictions += 1 if shifted
    end
    included
  end

  def each(&block)
    @stack.each(&block)
  end

  def inspect
    [
      "gets", @gets,
      "hits", @hits,
      "misses", @misses,
      "evictions", @evictions,
      "rate", @hits.to_f / @gets
    ].join("\t")
  end
end
