$LOAD_PATH.unshift 'lib'
require 'retort/version'

Gem::Specification.new do |s|
	s.name				= "retort"
	s.version			= Retort::VERSION
	s.authors			= ["Marcel Morgan"]
	s.email				= ["marcel.morgan@gmail.com"]

	s.summary			= "rtorrent xmlrpc ruby wrapper"
	s.description = <<-EOL
rtorrent xmlrpc wrapper written in ruby (1.9). Designed to decouple the 
xmlrpc interface from the underlying ruby objects.
EOL
	s.homepage 		= "http://github.com/mcmorgan/retort"

	#s.require_path    = 'lib'
	s.files = Dir.glob("lib/**/*.rb")
end
