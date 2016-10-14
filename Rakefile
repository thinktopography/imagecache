$LOAD_PATH.unshift File.expand_path("../lib", __FILE__)
require 'bundler/version'
require './lib/imagecache'
require './lib/imagecache/version'
require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec)

desc "Build the gem"
task :build do
  system "gem build backframe.gemspec"
end

desc "install the gem"
task :install do
  system "gem install backframe-#{imagecache::VERSION}.gem"
end

desc "Build and release the gem"
task :release => :build do
  system "gem push backframe-#{imagecache::VERSION}.gem"
end
