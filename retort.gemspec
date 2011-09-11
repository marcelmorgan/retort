# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "retort/version"

Gem::Specification.new do |s|
  s.name        = "retort"
  s.version     = Retort::VERSION
  s.authors     = ["Marcel Morgan"]
  s.email       = ["marcel.morgan@gmail.com"]
  s.homepage    = "https://github.com/mcmorgan/retort"
  s.summary     = %q{An rTorrent xmlrpc wrapper written in ruby}
  s.description = s.summary

  s.rubyforge_project = "retort"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_development_dependency "rspec"
end
