$LOAD_PATH.unshift 'lib'
require 'retort/version'

Gem::Specification.new do |s|
  s.name        = "retort"
  s.version     = Retort::VERSION
  s.authors     = ["Marcel Morgan"]
  s.email       = ["marcel.morgan@gmail.com"]

  s.summary     = "An rTorrent xmlrpc wrapper written in ruby"
  s.description = s.summary
  s.homepage    = "https://github.com/mcmorgan/retort"

  s.files = Dir.glob("lib/**/*.rb")
end
