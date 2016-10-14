$LOAD_PATH.unshift File.expand_path("../lib", __FILE__)
require 'bundler/version'
require './lib/imagecache'
require './lib/imagecache/version'
require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec)

desc "Build the gem"
task :build do
  system "gem build imagecache.gemspec"
end

desc "install the gem"
task :install do
  system "gem install imagecache-#{Imagecache::VERSION}.gem"
end

desc "Build and release the gem"
task :release => :build do
  system "gem push imagecache-#{Imagecache::VERSION}.gem"
end
