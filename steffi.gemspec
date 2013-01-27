Gem::Specification.new do |s|
  s.name        = 'steffi'
  s.version     = '0.0.0'
  s.date        = '2013-01-27'
  s.summary     = 'FFI bindings to the igraph library'
  s.description = s.summary
  s.authors     = ['James Dabbs']
  s.email       = 'jamesdabbs@gmail.com'
  s.files       = %w{ Gemfile steffi.gemspec }
  s.files      += Dir['lib/**/*.rb']
  s.homepage    = 'http://github.com/jamesdabbs/steffi'

  s.add_dependency 'ffi'
end