#!/opt/local/bin/ruby

def log(line)
  puts "#{Time.now}: #{line}"
end

class LinkedList
end

class EmptyList < LinkedList
  attr_accessor :prev

  def next
    nil
  end

  def inspect
    "[]"
  end
end

class Cons < LinkedList
  attr_accessor :item, :prev, :next

  def initialize(item, _next)
    @item = item
    @next = _next
  end

  def inspect
    "[#{item}, #{@next.inspect}]"
  end
end

class Lru
  attr_reader :evictions, :hits, :misses, :gets

  def initialize(slots)
    @slots = slots
    @index = {}
    @head = @nil = EmptyList.new
    @gets = @evictions = @hits = @misses = 0
    log "initializing LRU with #{@slots} slots"
  end

  def include?(item)
    @gets += 1
    if @index.has_key?(item)
      @hits += 1
      cell = @index[item]

      if prev = cell.prev # move before/move to top
        prev.next = cell.next
        cell.next.prev = prev
        cell.next = @head
        @head.prev = cell
        cell.prev = nil
        @head = cell
      end

      true
    else
      @misses += 1
      if @index.length == @slots # evict/shift
        @evictions += 1
        last_cell = @nil.prev
        second_to_last_cell = last_cell.prev
        @nil.prev = second_to_last_cell
        second_to_last_cell.next = @nil
        @index.delete(last_cell.item)
      end
      # push
      old_head = @head
      @head = Cons.new(item, old_head)
      old_head.prev = @head
      @index[item] = @head

      false
    end
  end
end

lru_size = ARGV[0] || 100_000

lru = Lru.new(lru_size)

hits = 0

GC.disable

ARGF.each_with_index do |line, idx|
  lru.include?(line)
  if (idx+1) % 50_000 == 0
    log "gets: #{lru.gets}, hits: #{lru.hits}, misses: #{lru.misses}, evictions: #{lru.evictions}, rate: #{lru.hits.to_f / lru.gets}"
    GC.start
    GC.disable
  end
end
