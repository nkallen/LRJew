lru_size = ARGV[0] || 100_000

lru = Lru.new(lru_size)

hits = 0

GC.disable

ARGF.each_with_index do |line, idx|
  lru.include?(line)
  if (idx+1) % 50_000 == 0
    puts "#{Time.now}: #{lru.inspect}"
    GC.start
    GC.disable
  end
end
