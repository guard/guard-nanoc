# encoding: utf-8

$LOAD_PATH.unshift(File.expand_path('../lib/', __FILE__))
require 'guard/nanoc/version'

Gem::Specification.new do |s|
  s.name          = 'guard-nanoc'
  s.version       = Guard::Nanoc::VERSION
  s.homepage      = 'http://nanoc.ws/'
  s.summary       = 'guard gem for nanoc'
  s.description   = 'Automatically rebuilds nanoc sites'
  s.license       = 'MIT'

  s.author        = 'Denis Defreyne'
  s.email         = 'denis.defreyne@stoneship.org'

  s.files         = Dir['[A-Z]*'] + Dir['lib/**/*'] + [ 'guard-nanoc.gemspec' ]
  s.require_paths = [ 'lib' ]
end
