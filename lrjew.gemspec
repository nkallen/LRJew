spec = Gem::Specification.new do |s|
  s.name = 'lrjew'
  s.version = Gem::Version.new("1.0")
  s.summary = "An LRU simulator"
  s.description = s.summary
  s.email = ['stevej@twitter.com', 'nick@twitter.com']
  s.authors = ['Steve Jenson', 'Nick Kallen']
  s.files = ['Rakefile', Dir['lib/**/*.rb'], Dir['bin/*']].flatten
  s.executables << 'lrjew'
  s.test_files = Dir['spec/**/*']
end
