lib = File.expand_path '../lib', __FILE__
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'steffi/version'

Gem::Specification.new do |s|
  s.name        = 'steffi'
  s.version     = Steffi::Version
  s.date        = '2013-01-27'
  s.summary     = 'FFI bindings to the igraph library'
  s.description = s.summary
  s.authors     = ['James Dabbs']
  s.email       = 'jamesdabbs@gmail.com'
  s.files       = %w{ Gemfile steffi.gemspec }
  s.files      += Dir['lib/**/*.rb'] + Dir['ext/**/*']
  s.homepage    = 'http://github.com/jamesdabbs/steffi'

  s.add_dependency 'ffi'
end