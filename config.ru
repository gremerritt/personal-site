require 'rack/jekyll'
require 'yaml'
puts `ls -R ./`
run Rack::Jekyll.new
