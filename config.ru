require 'rack/jekyll'
require 'yaml'
Dir.chdir(File.expand_path("web"))
run Rack::Jekyll.new
